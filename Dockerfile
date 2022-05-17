FROM ubuntu:latest

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/print-cron

# Add testpage pdf
ADD testpage.pdf /testpage.pdf

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/print-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#Install packages
RUN apt-get update
RUN apt-get -y install cups-client cron

# Print to the first available network destination
RUN lp -d $(lpstat -e | sed 1q) /testpage.pdf

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
