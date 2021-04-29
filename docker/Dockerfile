#Download Python from DockerHub and use it
FROM python:3

#Set the working directory in the Docker container
WORKDIR /web-app

#Copy the dependencies file to the working directory
COPY requirements.txt .

#Install the dependencies
RUN pip install -r requirements.txt

#Copy the Flask app code to the working directory
COPY app.py .

#Expose the required port
EXPOSE 5000

#Run the container
CMD [ "python", "./app.py" ]
