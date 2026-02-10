function InitializeControl(controlId) {
    var controlAddIn = document.getElementById(controlId);
    controlAddIn.innerHTML ='<div id="my-tif"/>';
}

function SetVisible(IsVisible) {
    if (IsVisible){
        document.querySelector("#my-tif").style.display = 'block';
    }else{
        document.querySelector("#my-tif").style.display = 'none';
    }

}

async function LoadTIF(PDFDocument){
    const blob = b64toBlob(PDFDocument, 'image/tiff');
    const buffer = await blob.arrayBuffer();

    Tiff.initialize({TOTAL_MEMORY: 16777216 * 10});
    const tiff = new Tiff({buffer: buffer});

    var jsPDF = window.jspdf.jsPDF;
    let doc = new jsPDF({
        orientation: 'p',
        unit: 'px',
        options: {
        hotfixes: ["px_scaling"]
        },
        format: [tiff.height(),tiff.width()]
    });

    if (tiff.height() < tiff.width()){
        doc = new jsPDF({
            orientation: 'l',
            unit: 'px',
            options: {
            hotfixes: ["px_scaling"]
            },
            format: [tiff.height(),tiff.width()]
        });
    }

    for (var i = 0, len = tiff.countDirectory(); i < len; ++i) {
        tiff.setDirectory(i);
        const canvas = tiff.toCanvas();

        if (i > 0){
            if (tiff.height() >= tiff.width()){
                // Portrait
                doc.addPage([tiff.height(),tiff.width()],'p');
            }
            if (tiff.height() < tiff.width()){
                // landscape
                doc.addPage([tiff.height(),tiff.width()],'l');
            }
        }
        doc.addImage(canvas, "JPEG", 0, 0, tiff.width(),tiff.height());

        console.log(`Page ${i+1}.height => ${tiff.height()}`);
        console.log(`Page ${i+1}.width => ${tiff.width()}`);
    }

    // doc is a PDF document by now..
    var iframe = window.frameElement;
    requestAnimationFrame(() => {
        const blobUrl = URL.createObjectURL(doc.output('blob'));

        console.log(blobUrl);
        
        PDFObject.embed(blobUrl, "#my-tif");

        iframe.style.maxHeight = 72.5 + 'vh';
        iframe.style.height =  72.5 + 'vh';
        // iframe.style.maxHeight = 75 + 'vh';
        // iframe.style.height =  75 + 'vh';
    });
}

const b64toBlob = (b64Data, contentType='', sliceSize=512) => {
    const byteCharacters = atob(b64Data);
    const byteArrays = [];
  
    for (let offset = 0; offset < byteCharacters.length; offset += sliceSize) {
      const slice = byteCharacters.slice(offset, offset + sliceSize);
  
      const byteNumbers = new Array(slice.length);
      for (let i = 0; i < slice.length; i++) {
        byteNumbers[i] = slice.charCodeAt(i);
      }
  
      const byteArray = new Uint8Array(byteNumbers);
      byteArrays.push(byteArray);
    }
  
    const blob = new Blob(byteArrays, {type: contentType});
    return blob;
}