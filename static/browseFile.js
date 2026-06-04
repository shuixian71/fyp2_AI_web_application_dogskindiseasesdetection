const file = document.getElementById("click");
const container = document.querySelector(".container");
const btn = document.querySelector("label");
const fileName = document.querySelector(".file-name");
const fileSize = document.querySelector(".file-size");
// const deleteBtn = document.querySelector(".fa-trash");
const deleteBtn = document.querySelector(".iconbox");

// for drag and drop image file functionality
// reference from : https://dev.to/inancakduvan/drag-and-drop-to-upload-a-photo-javascript-css-3277
const dropContainer = document.querySelector(".container");
const dropfileName = document.querySelector(".file-name");


//show the uploaded file in the preview form when user browse and select a file
file. addEventListener("change", ()=>{
    if (file.files.length ===0) {
        console.log("No file selected");
    } else{
        console.log("Image File Selected");
        container.classList.add("active");
        fileName.innerHTML = `${file.files[0].name}`
        fileSize.innerHTML = `${Math.round(file.files[0].size / 1024)} KB`;
         
        
    }
});

//delete the uploaded file using delete icon
deleteBtn.addEventListener("click", ()=>{
    file.value="";
    container.classList.remove("active");

})

//prevent default behaviour of dragover event (image dropped is in blank tab if no prevent default)
dropContainer.addEventListener("dragover",(event)=>{
    event.preventDefault();
});

//drop file, apply prevent default behavior which vaidate the uploaded file is image and display the info
dropContainer.addEventListener("drop",(event)=>{
    event.preventDefault();
    
    let file;

    if (event.dataTransfer.items){
        const item= event.dataTransfer.items[0];

        const isFile = item.kind === "file";
        const isImage = item.type.split("/")[0] === "image";

        //check if the dropped file is a file and belongs to image
        if(isFile && isImage){
            file = item.getAsFile();
        }else{
            alert("Uploaded file is not an image!")
            return;
        }

    }else{
        file = event.dataTransfer.files[0];
    }

    //section to show the dropped file info
    if(file){
        container.classList.add("active");
        fileName.innerHTML = file.name;
        fileSize.innerHTML = `${Math.round(file.size/1024)} KB`;

        // add the the drag and drop file to the input
        const dataTransfer = new DataTransfer();
        dataTransfer.items.add(file);
        document.getElementById('click').files = dataTransfer.files;
    }
});