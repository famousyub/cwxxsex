import requests

# initialize the Keras REST API endpoint URL along with the input
# image path
KERAS_REST_API_URL = "http://localhost:5000/predict"
IMAGE_PATH = "./mobile/dog.jpeg"
#"http://localhost:82/famousme//upload/photos/2022/03/FOa5ckmxJwQ1li7GXtac_10_b5b8961237969e2a28c01a59aab059c9_image.jpg"

# load the input image and construct the payload for the request
image = open(IMAGE_PATH, "rb").read()
print(image)
payload = {"image": image}

# submit the request
r = requests.post(KERAS_REST_API_URL, files=payload).json()

# ensure the request was sucessful
if r["success"]:
	# loop over the predictions and display them
	for (i, result) in enumerate(r["predictions"]):
		print("{}. {}: {:.4f}".format(i + 1, result["label"],
			result["probability"]))

# otherwise, the request failed
else:
	print("Request failed")


# Run this script as root

import time
from datetime import datetime as dt

# change hosts path according to your OS
hosts_path = "/etc/hosts"
# localhost's IP
redirect = "127.0.0.1"

# websites That you want to block
website_list =
["www.facebook.com","facebook.com",
	"dub119.mail.live.com","www.dub119.mail.live.com",
	"www.gmail.com","gmail.com"]

while True:

	# time of your work
	if dt(dt.now().year, dt.now().month, dt.now().day,8)
	< dt.now() < dt(dt.now().year, dt.now().month, dt.now().day,16):
		print("Working hours...")
		with open(hosts_path, 'r+') as file:
			content = file.read()
			for website in website_list:
				if website in content:
					pass
				else:
					# mapping hostnames to your localhost IP address
					file.write(redirect + " " + website + "\n")
	else:
		with open(hosts_path, 'r+') as file:
			content=file.readlines()
			file.seek(0)
			for line in content:
				if not any(website in line for website in website_list):
					file.write(line)

			# removing hostnmes from host file
			file.truncate()

		print("Fun hours...")
	time.sleep(5)
