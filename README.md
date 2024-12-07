#  RoadBuddy - Machine Learning based driver assistant system to reduce road accidents 


**Our Team:**  

Somarathne R.M.B.C    - IT21210938  
Wijerathne G.A.R      - IT21349638  
Nayanathara R.M.C     - IT21365300  
Neelawala P.K.N.G.K.B - IT21231728


![systemmmmm](https://github.com/user-attachments/assets/0dff5eea-5632-4a93-b0df-73a585031358)


**Problem Statement**

Road safety is a significant concern in Sri Lanka, with high rates of accidents and fatalities. The main contributing factors include reckless driving, inadequate road sign detection, poor lane discipline, and lack of driver education. Additional challenges arise due to limited technological integration in existing driving systems, including insufficient driver monitoring and the absence of comprehensive driver assistance mechanisms.


**Key issues include:**

Reckless Driver Behavior: Lack of proper driver education and awareness leads to unsafe driving practices.

Inefficient Parking: Drivers face challenges identifying available parking spots and ensuring proper alignment.

Inadequate Road Sign Awareness: Drivers struggle to recognize and interpret road signs, particularly in low visibility conditions.

Blind Spots: Limited awareness of objects or obstacles in vehicle blind spots increases the risk of accidents.


**Solutions for Each Component**

1. Driver Identification and Vision Monitoring

Problem: Unauthorized access to vehicles and reckless driving behavior contribute to unsafe conditions.

Solution: This system uses advanced biometric authentication to identify authorized drivers. Facial recognition and driver behavior monitoring detect and alert reckless behavior, ensuring safer driving practices. Security alerts notify vehicle owners of unauthorized access.

Technology: React Native for interface, Python for backend, TensorFlow for behavior analysis, and Inception V3 for face recognition.


2. Parking Spot Detection

Problem: Difficulty in finding parking spots and aligning vehicles properly.

Solution: A parking assistance feature identifies available spots and ensures proper parking alignment. This system integrates data analytics to guide drivers to the nearest parking spot and detect alignment issues.

Technology: MobileNetV2 algorithm for object detection and parking line identification.


3. Enhanced Road Sign Detection

Problem: Difficulty in detecting and interpreting road signs, especially under poor visibility or environmental conditions.

Solution: Real-time road sign detection and interpretation provide warnings and alerts to drivers. The system also narrates road sign information to improve situational awareness and adherence to speed limits and road conditions.

Technology: YOLOv11 for road sign recognition, TensorFlow for AI modeling, and Google Colab for training datasets.


4. Blind Spot Detection

Problem: Unawareness of objects or vehicles in blind spots results in accidents.

Solution: Real-time blind spot monitoring and distance measurement alert drivers to objects, long vehicles, or pedestrians in blind spots. It also assists in overtaking maneuvers, ensuring safety.

Technology: MobileNet and YOLOv11 for object detection, TensorFlow for distance measurement, and React Native for driver alerts.


**System Architecture Overview**

Frontend: Developed using React Native for an intuitive user interface.

Backend: Python handles data processing, predictive analysis, and communication with sensors and cameras.

Machine Learning Framework: TensorFlow is used for training and deploying models for image and behavior analysis.

Training Environment: Google Colab provides scalable resources for training deep learning models.


**Algorithms Used**

Convolutional Neural Networks (CNN): Applied for analyzing images, such as road signs and driver faces.

Inception V3: Used for advanced face recognition in driver identification.

MobileNet & MobileNetV2: Optimized for lightweight object detection tasks, such as parking alignment and blind spot monitoring.

YOLOv11: Real-time detection of road signs and blind spot objects with high accuracy.

**Dependencies Used**

tensorflow
keras
scikit-learn
matplotlib and seaborn

**Expected Benefits**

Reduced Accidents: Advanced assistance features promote responsible driving and reduce risks.

Enhanced Road Awareness: Real-time alerts improve drivers' ability to react promptly to changing road conditions.

Improved Parking Efficiency: Drivers save time and effort in parking with guided assistance.

Driver Authentication: Prevents unauthorized access and ensures vehicle security.

By addressing the key road safety challenges in Sri Lanka, this system integrates cutting-edge technologies to foster a safer and more efficient driving environment.

