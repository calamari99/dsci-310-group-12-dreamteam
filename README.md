# dsci-310-group-12-dreamteam
- Authors: Enoch Cheung

Demo of Facebook-Post-Predictor from DSCI100.

## About
We attempt to build out a K-nearest neighbour classification model to predict a type of social media posting (ie: photo/video/status/etc.) using data mined from a cosmetic company's facebook page. The model performed mediocrely reporting an accuracy of ~92% due to an unbalanced dataset where videos, links, and statuses made up much less of the total observations in testing. 

The data is collected from: https://archive.ics.uci.edu/ml/datasets/Facebook+metrics

## Report
The analysis report is attached [here](https://github.com/calamari99/Facebook-Post-Predictor/blob/main/submission.ipynb).

## Usage
0a. Environment setup
- Install Docker in your computer.
- Log into Docker account.

1a. Clone Repo to local machine from terminal
- `Git clone https://github.com/calamari99/dsci-310-group-12-dreamteam.git`

2a. Build docker image and file OR pull from hub in 2b
- `docker build -t <group12v5> .`

2b. Pull from docker hub with version needed for grading (version3.0 for milestone 2)
- `docker pull calamari99/group12v5:version3.0`

3a. Running jupyter file using docker image from step 2.
- `docker run --rm -it\
    -p 8888:8888   \
    -v ${PWD}:/home/jovyan/work \
    calamari99/group12v5:version3.0`

<!-- `docker container run -d -p 8888:8888 -e JUPYTER_TOKEN=enter -e GRANT_SUDO=yes --user root --name test  –<dockerimage>` -->

<!--  Docker credential issues:
1. Logout of Docker:
` docker logout `

2. Build image with tag using:
` docker tag <imagename> <userID/imagename:tagname> 

3. Login to docker
` docker login `

4. Push image
` docker push <userID/imagename:tagname> 
-->

4a. Copy and paste a URL that was populated in step 3 starting with:
- `http://127.0.0.1:8888/lab?token=<token>`


5a. Open jupyter notebook in notebooks folder and run all cells.


## License
MIT license for project analysis

# References
Credit to DSCI100 group: Sara Jafroudi, Enoch Cheung, Jason Ngo, Bruno Gagnon
https://github.com/calamari99/Facebook-Post-Predictor

