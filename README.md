# RoadBuddy - Machine Learning-Based Driver Assistance System

## Team Members

- **Somarathne R.M.B.C** - IT21210938
- **Wijerathne G.A.R** - IT21349638
- **Nayanathara R.M.C** - IT21365300
- **Neelawala P.K.N.G.K.B** - IT21231728
  
---

### GitHub Repository Link: [CDAP197-DAA](https://github.com/bimsara2333/CDAP197-DAA)

---

## Overview

RoadBuddy is a machine learning-driven application designed to enhance road safety and reduce accidents in Sri Lanka. The system integrates advanced technologies to address critical road safety challenges such as reckless driving, parking inefficiencies, blind spot awareness, and road sign interpretation.

---

## System Architecture Diagram

![systemmmmm](https://github.com/user-attachments/assets/b8ed6447-17d1-488c-a73b-9bfb8e8f2868)


---

## Problem Statement
Road safety is a significant concern in Sri Lanka, with high rates of accidents and fatalities. The main contributing factors include reckless driving, inadequate road sign detection, poor lane discipline, and lack of driver education. Additional challenges arise due to limited technological integration in existing driving systems, including insufficient driver monitoring and the absence of comprehensive driver assistance mechanisms.

**Key issues include:**

- **Reckless Driver Behavior:** Limited awareness leads to unsafe practices.
- **Inefficient Parking:** Difficulty in locating and aligning parking spots.
- **Inadequate Road Sign Awareness:** Struggles with recognizing road signs, especially under low visibility.
- **Blind Spots:** Increased risk due to undetected obstacles in vehicle blind spots.

---

## Solutions By Component

### 1. **Driver Identification and Vision Monitoring**

- **Problem:** Unauthorized access to vehicles and reckless driving behavior contribute to unsafe conditions.
- **Solution:** This system uses advanced biometric authentication to identify authorized drivers. Facial recognition and driver behavior monitoring detect and alert reckless behavior, ensuring safer driving practices. Security alerts notify vehicle owners of unauthorized access.
- **Technology:** React Native for interface, Python for backend, TensorFlow for behavior analysis, and Inception V3 for face recognition.

### 2. **Parking Spot Detection**

- **Problem:** Difficulty in finding parking spots and aligning vehicles properly.
- **Solution:** A parking assistance feature identifies available spots and ensures proper parking alignment. This system integrates data analytics to guide drivers to the nearest parking spot and detect alignment issues.
- **Technology:** MobileNetV2 algorithm for object detection and parking line identification.

### 3. **Enhanced Road Sign Detection**

- **Problem:** Difficulty in detecting and interpreting road signs, especially under poor visibility or environmental conditions.
- **Solution:** Real-time road sign detection and interpretation provide warnings and alerts to drivers. The system also narrates road sign information to improve situational awareness and adherence to speed limits and road conditions.
- **Technology:** YOLOv11 for road sign recognition, TensorFlow for AI modeling, and Google Colab for training datasets.

### 4. **Blind Spot Detection**

- **Problem:** Unawareness of objects or vehicles in blind spots results in accidents.
- **Solution:** Real-time blind spot monitoring and distance measurement alert drivers to objects, long vehicles, or pedestrians in blind spots. It also assists in overtaking maneuvers, ensuring safety.
- **Technology:** MobileNet for object detection, TensorFlow for distance measurement, and React Native for driver alerts.

---

## System Architecture

- **Frontend:** Developed using React Native for an intuitive user interface.
- **Backend:** Python handles data processing, predictive analysis, and communication with sensors and cameras.
- **Machine Learning Framework:** TensorFlow is used for training and deploying models for image and behavior analysis.
- **Training Environment:** Google Colab provides scalable resources for training deep learning models.

---

## Algorithms and Technologies

- **Convolutional Neural Networks (CNN):** Applied for analyzing images, such as road signs and driver faces.
- **Inception V3:** Used for advanced face recognition in driver identification.
- **MobileNet & MobileNetV2:** Optimized for lightweight object detection tasks, such as parking alignment and blind spot monitoring.
- **YOLOv11:** Real-time detection of road signs and blind spot objects with high accuracy.

---

## Dependencies

- **TensorFlow**
- **Keras**
- **Scikit-learn**
- **Matplotlib**
- **Seaborn**

---

## Expected Benefits

- **Reduced Accidents:** Advanced assistance features promote responsible driving and reduce risks.
- **Enhanced Road Awareness:** Real-time alerts improve drivers' ability to react promptly to changing road conditions.
- **Improved Parking Efficiency:** Drivers save time and effort in parking with guided assistance.
- **Driver Authentication:** Prevents unauthorized access and ensures vehicle security.

---

By addressing key road safety challenges in Sri Lanka, RoadBuddy integrates cutting-edge machine learning technologies to foster a safer and more efficient driving experience.

