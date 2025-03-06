import json , time
from flask import Flask, jsonify, request, make_response , send_from_directory
from flask_cors import CORS
import requests
import shutil
from ultralytics import YOLO
import cv2
from postprocessing import *
import collections,numpy
import numpy as np
import tensorflow as tf
from tensorflow.keras.preprocessing.image import load_img , img_to_array
from keras.models import load_model
from tensorflow.keras.preprocessing import image
import tensorflow_hub as hub
import os
import pickle
from tensorflow.keras.utils import custom_object_scope
import math
import uuid

blind_spot_model = tf.keras.models.load_model(
       ('blind_spot_model.h5'),
       custom_objects={'KerasLayer':hub.KerasLayer}
)

eye_model = tf.keras.models.load_model(
       ('eye_model.h5'),
       custom_objects={'KerasLayer':hub.KerasLayer}
)

face_model = tf.keras.models.load_model(
       ('face_model.h5'),
       custom_objects={'KerasLayer':hub.KerasLayer}
)

parking_model = tf.keras.models.load_model(
       ('parking_model.h5'),
       custom_objects={'KerasLayer':hub.KerasLayer}
)

def blind_spot_find(filename):
    classes = ['Drains And Ditches', 'Moving Objects', 'Small Vehicles','Static Objects', 'Two Wheel Vehicles', 'Long Vehicle']
    img_ = image.load_img(filename, target_size=(224, 224))
    img_array = image.img_to_array(img_)
    img_processed = np.expand_dims(img_array, axis=0)
    img_processed /= 255.
    
    model = blind_spot_model
    prediction = model.predict(img_processed)
    index=np.argmax(np.max(prediction, axis=0))
    array=np.max(prediction, axis=0)
    
    return str(classes[index]).title(),array[index]*100

def eye_find(filename):
    classes = ['Half open eye', 'closeEye', 'openEye']
    img_ = image.load_img(filename, target_size=(224, 224))
    img_array = image.img_to_array(img_)
    img_processed = np.expand_dims(img_array, axis=0)
    img_processed /= 255.
    
    model = eye_model
    prediction = model.predict(img_processed)
    index=np.argmax(np.max(prediction, axis=0))
    array=np.max(prediction, axis=0)
    
    return str(classes[index]).title(),array[index]*100

def face_find(filename):
    classes = ['Drinking while driving','Safe Driving','Sleepy and Yawny','Using Devices while driving']
    img_ = image.load_img(filename, target_size=(224, 224))
    img_array = image.img_to_array(img_)
    img_processed = np.expand_dims(img_array, axis=0)
    img_processed /= 255.
    
    model = face_model
    prediction = model.predict(img_processed)
    index=np.argmax(np.max(prediction, axis=0))
    array=np.max(prediction, axis=0)
    
    return str(classes[index]).title(),array[index]*100

def parking_find(filename):
    classes = ['Available', 'No Parking', 'Parking Full']
    img_ = image.load_img(filename, target_size=(224, 224))
    img_array = image.img_to_array(img_)
    img_processed = np.expand_dims(img_array, axis=0)
    img_processed /= 255.
    
    model = parking_model
    prediction = model.predict(img_processed)
    index=np.argmax(np.max(prediction, axis=0))
    array=np.max(prediction, axis=0)
    
    return str(classes[index]).title(),array[index]*100

road_signs_model = YOLO("road_signs.pt")
class_list = road_signs_model.model.names
scale_show = 100

def capture_image_camera0():
    cap = cv2.VideoCapture(1)
    if not cap.isOpened():
        raise Exception("Error: Camera could not be opened.")
    
    ret, frame = cap.read()
    cap.release()

    if not ret:
        raise Exception("Error: Failed to capture image.")

    unique_filename = f"{uuid.uuid4()}.jpg"
    image_path = os.path.join('temp', unique_filename)

    cv2.imwrite(image_path, frame)

    return unique_filename, image_path

app = Flask(__name__)

@app.after_request
def after_request(response):
  response.headers.add('Access-Control-Allow-Origin', '*')
  response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
  response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
  return response

@app.route('/blind_spot', methods=['GET'])
def blind_spot():
    
        unique_filename, image_path = capture_image_camera0()

        res,accuracy =blind_spot_find(image_path)

        if round(accuracy,2)>90:
            res=res
            accuracy=accuracy*10
        elif round(accuracy,2)<90:
            res="No Detected"
            accuracy=0

        print(accuracy)

        json_dump = json.dumps({"res":res,"accuracy":str(round(accuracy,2)),"image":str(unique_filename),"success":"true"})

        return json_dump
    
@app.route('/parking', methods=['GET'])
def parking():
    
        unique_filename, image_path = capture_image_camera0()

        res,accuracy =parking_find(image_path)

        if round(accuracy,2)>90:
            res=res
            accuracy=accuracy*10
        elif round(accuracy,2)<90:
            res="No Detected"
            accuracy=0

        print(accuracy)

        json_dump = json.dumps({"res":res,"accuracy":str(round(accuracy,2)),"image":str(unique_filename),"success":"true"})

        return json_dump
    
    
@app.route('/eye_face', methods=['GET'])
def eye_face():
    
        unique_filename, image_path = capture_image_camera0()

        res1,accuracy1 =eye_find(image_path)
        res2,accuracy2 =face_find(image_path)

        if round(accuracy1,2)>90:
            res1=res1
            accuracy1=accuracy1*10
        elif round(accuracy1,2)<90:
            res1="No Detected"
            accuracy1=0
            
        if round(accuracy2,2)>90:
            res2=res2
            accuracy2=accuracy2*10
        elif round(accuracy2,2)<90:
            res2="No Detected"
            accuracy2=0

        json_dump = json.dumps({"res1":res1,"accuracy1":str(round(accuracy1,2)),"res2":res2,"accuracy2":str(round(accuracy2,2)),"image":str(unique_filename),"success":"true"})

        return json_dump
    
    
@app.route('/road_signs', methods=['GET'])
def road():
    
        unique_filename, image_path = capture_image_camera0()

        frame = cv2.imread(image_path)

        results = road_signs_model.predict(frame)
        
        print(results)

        json_dump = json.dumps({"percentage_value":str(results),"success":"true"})

        return json_dump
    
@app.route('/images/<filename>')
def get_image(filename):
    return send_from_directory("temp", filename)

if __name__ == '__main__':
	app.run(host="0.0.0.0", port=5555)