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

Tops: 
* Instead of the input file `/files/sample.html' , you can provide any URL as well
* You can replace the part after 'wkhtmltopdf', with '-H', to see various command line options the tool offers
