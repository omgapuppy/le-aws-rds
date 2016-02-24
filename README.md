## Sending AWS RDS logs to Logentries

Collecting log data from Amazon RDS instances can be done through HTTP POST.  There is some configuration required to make this happen.

This document was created using a Linux based EC2 instance.

### Required Configuration

* Obtain the [AWS RDS Command Line Tools](Install the AWS RDS Command Line Tools)
  * ` wget http://s3.amazonaws.com/rds-downloads/RDSCli.zip `
* Copy the zip file to your desired installation path and unzip


* Set up the following environment variables:
  * `export JAVA_HOME=<PATH>`
  * `export AWS_RDS_HOME=<path-to-tools>`
  * `export PATH=$PATH:$AWS_RDS_HOME/bin`


* Set up your credentials by entering access keys here:
  * `$AWS_RDS_HOME/credential-file-path.template`
  * [Documentation for providing the tools with credentials](http://docs.aws.amazon.com/AmazonRDS/latest/CommandLineReference/StartCLI.html)
  * [Documentation for setting up IAM user](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAM.html)


* Verify that the tools were set up correctly:
  * `rds-describe-db-log-files <rds instance name here>`
* If the last step returns a list of available log files, the tools were set up correctly. If any issues occur, please refer to AWS documentation linked above.


### Sending logs to Logentries

* [Set up a token based log in your Logentries account](https://logentries.com/doc/input-token/)
* Download and edit `le-rds.sh` from this repo, replacing `TOKEN="YOUR_LOG_TOKEN"` value with the token obtained in previous step
* Run `chmod +x le-rds.sh` to make the script executable
* Test by launching the script in background:
  * `$ nohup sh -c 'rds-watch-db-logfile <your db instance name> --log-file-name <your db log file name> | ./le_rds.sh'`


### Alternatively, use Logentries Linux Agent

* [Install the agent](https://logentries.com/doc/linux-agent/)
* Create a file to monitor i.e `/var/log/rds_to_le.log`
* Run `sudo le follow /var/log/rds_to_le.log`
* Run `rds-watch-db-logfile <your db instance name> --log-file-name <your db log file name> > /var/log/rds_to_le.log`
