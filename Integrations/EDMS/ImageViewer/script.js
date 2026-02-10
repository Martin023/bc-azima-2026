function InitializeControl(controlId) {
    var controlAddIn = document.getElementById(controlId);
    controlAddIn.style.overflow = 'auto';
    controlAddIn.innerHTML ='<img id="my-image"/>';
}

function SetVisible(IsVisible) {
    if (IsVisible){
        document.querySelector("#my-image").style.display = 'block';
    }else{
        document.querySelector("#my-image").style.display = 'none';
    }

}

function LoadImage(ImageDocument,IsFactbox){
    var iframe = window.frameElement;

    console.log(ImageDocument);

    requestAnimationFrame(() => {
        const blob = b64toBlob(ImageDocument, "");
        const blobUrl = URL.createObjectURL(blob);

        console.log(blobUrl);
        
        document.querySelector("#my-image").src = blobUrl;

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