# dsci-310-group-12-dreamteam
- Authors: Enoch Cheung

Demo of Facebook-Post-Predictor from DSCI100.

## About
We attempt to build out a K-nearest neighbour classification model to predict a type of social media posting (ie: photo/video/status/etc.) using data mined from a cosmetic company's facebook page. The model performed mediocrely reporting an accuracy of ~92% due to an unbalanced dataset where videos, links, and statuses made up much less of the total observations in testing. 

The data is collected from: https://archive.ics.uci.edu/ml/datasets/Facebook+metrics

## Report
The analysis report is attached [here](https://github.com/calamari99/Facebook-Post-Predictor/blob/main/submission.ipynb).

## Usage

1. Clone Repo to local machine from terminal
`Git clone https://github.com/calamari99/dsci-310-group-12-dreamteam.git`

2. Build docker image and file.
`docker build -t <group12v3> .`

3. Running jupyter file using docker image from step 2.
`docker container run -d \
    -p 8888:8888   \
    -v /$(pwd):/opt/notebooks/submission.ipynb \
    -e JUPYTER_TOKEN=enter \
    -e GRANT_SUDO=yes \
    --user root \
    --name test  \
    eb93706bb5394fb793562bd98ba1822e70c2aa90352746fa2ca1159fb9d6dff2

<!-- `docker container run -d -p 8888:8888 -e JUPYTER_TOKEN=enter -e GRANT_SUDO=yes --user root --name test  –<dockerimage>` -->

4. Swap to notebooks folder from root folder
`cd notebooks`

5. Trust notebook.
`jupyter trust submission.ipynb`

6. Open jupyter lab.
` jupyter lab`

7. Open jupyter notebook in notebooks folder.


## License

# References
Credit to DSCI100 group: Sara Jafroudi, Enoch Cheung, Jason Ngo, Bruno Gagnon
https://github.com/calamari99/Facebook-Post-Predictor
