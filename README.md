### The challenge: 
I have been looking for a decent HTML to PDF converter library within Python; and sadly the existing options perform miserably when generating the pdf.  Among other options, the most reasonable performer was this command line tool called [wkhtmltopdf]("https://wkhtmltopdf.org"). The tool, however, hasn't been updated since 2022 and some of the libraries it relies on have been deprecated. Which makes it an unsafe choice for command line, even if its made to work. Besides, I wanted to limit the resources the tool consume. 

### The solution:
Containers were the obvious solution! There are actually some Docker images on docker hub, but their Dockerfile is not shared. Hence this repository. 
The repo shares the simple Dockerfile that you can use to build an html2pdf converter, and run it from commandline. 

### The steps to build:
```
podman build . -t html2pdf
```
In case the rpms uses to build the PDF are no longer download-able, a copy of those unmodified RPM is also included in this Git repo

### The steps to run: 
With the html file (`sample.html` in this example) in your current directory: 
```
podman run --name html2pdf -it --rm -v $(pwd)/:/files:Z localhost/html2pdf wkhtmltopdf -s "Legal" --title "sample pdf" /files/sample.html /files/sample.pdf
```

Tips: 
* Instead of the input file `/files/sample.html' , you can provide any URL as well
* You can replace the part after 'wkhtmltopdf', with '-H', to see various command line options the tool offers

### To run securely:
Since the intent of running this as container was to limit what the application can do and how many resources it can consume, the following additional flags can be used when running it. Use of podman already limits the ability of the container to some extent, but these additional flags are inline with the generic hardening steps on top of running a non-root container: 
```
podman run --name html2pdf -it --rm --userns=keep-id --read-only --pids-limit 50 --memory 8m --cap-drop ALL --network none -v $(pwd)/:/files:Z localhost/html2pdf wkhtmltopdf -s "Legal" --title "sample pdf" /files/sample.html /files/sample.pdf
```

Note, in addition to the above, cpu resources can also be limited using "--cpus 0.5" or "--cpu-quota=50000 --cpu-period=100000" parameters. Your system will suppor that only if you see cpu in the output of : 'find /sys/fs/cgroup -type d'
