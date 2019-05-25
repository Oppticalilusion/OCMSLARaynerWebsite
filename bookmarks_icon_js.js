// File to hold all my javascript functions

// ---------- Function for the bookmarkIcon class ----------
// Handles all functionality of the bookmark icon and its properties
// Deals with localstorage variables and the state of the bookmark icon

function BookmarkInit(urlValue, ImageUrl, selectedImageUrl) {

    // Check to see if bookmark exists, and create an local var with the information (or fresh)
    if (localStorage.getItem("bookmarks") === null) {
        var bookmarks = [];
    } else {
        var bookmarks = JSON.parse(localStorage.getItem("bookmarks"));
    }

    // -------- Set the image of the bookmark based on page status -------------
    if(bookmarks.includes(urlValue)) {
        document.getElementById("theBookmark").src = selectedImageUrl;
        // Should be bookmarked
    } else {
        document.getElementById("theBookmark").src = ImageUrl;
        // Should be un-bookmarked
    }
    // -------------------------------------------------------------------------

    // ----- If else ladder to determine which bookmark state to display -------
    $("#theBookmark").on("click", function() {
        // If something exists in storage
        if (localStorage.getItem("bookmarks") != null) {
            var removed = JSON.parse(localStorage.getItem("bookmarks"));
            var tester = removed.includes(urlValue);
            if (tester == true) { // Check if current page is in the array
                for (var i = 0; i < removed.length; i++) { // Loop through array to find current page
                    if (urlValue === removed[i]) {
                        removed.splice(i, 1); // Remove from the array
                        removed.sort(); // Sort the array (alphabetically)
                        localStorage.setItem("bookmarks", JSON.stringify(removed)); // Send the new array back to storage
                        break;
                    }
                }
                document.getElementById("theBookmark").src = ImageUrl; // Set bookmark image to true (marked)
            } else { // Does not exist in array ( already been bookmarked )
                var stored = JSON.parse(localStorage.getItem("bookmarks")); // Pull the current array
                stored.push(urlValue); // Add the current page
                stored.sort();
                localStorage.setItem("bookmarks", JSON.stringify(stored)); // Store the new array
                document.getElementById("theBookmark").src = selectedImageUrl; // Set bookmark image to false (un-marked)
            }
        } else { // Nothing exists ( No page has been bookmarked )
            var stored = []; // Create new array
            stored.push(urlValue);
            localStorage.setItem("bookmarks", JSON.stringify(stored));
            document.getElementById("theBookmark").src = selectedImageUrl;
        }
    });
}

// ------------------------------- End Function -------------------------------------

// ---------- Function for the bookmarkCatcher class ---------
// Handles all the functionality of the bookmark catcher list and its properties
// Function only runs when there are bookmarks in storage

function BCatcherInit() {
    if (localStorage.getItem("bookmarks") != null) {
        var pullStorage = JSON.parse(localStorage.getItem("bookmarks"));
        var storageLength = pullStorage.length;

        // Create the <ul> element here
        var bList = document.createElement("ul");
        bList.className = "bookmarks_ul_class";
        var placeholder = document.getElementsByClassName("bookmarks_m_class");
        var newUL = placeholder[0]; // Find the menu item used
        newUL.style.display = "inline-block"; // Make it visible on this page
        newUL.appendChild(bList); // Add the new ul element ( the bookmark ( which is empty currently ))
        // ----------------------------

        for(var i = 0; i < storageLength; i++) {
            var currentStorage = pullStorage[i]; // Keep track of the current page url
            var dpageName = currentStorage; // Var to be broken down into just the pageName
            // Once pulled, split down to just the name of the page
            dpageName = dpageName.split("name=")[1]; // Remove left side
            dpageName = dpageName.split("&")[0]; // Remove right side


            // Create the <li> element here
            var node = document.createElement("LI");
            node.id = "linkButtons";
            node.className = dpageName;
            var textnode = document.createTextNode(dpageName);
            node.appendChild(textnode);
            var temporary = document.getElementsByClassName("bookmarks_ul_class");
            var newIL = temporary[0];
            newIL.appendChild(node); // Attach new il element to earlier created ul element
            // ----------------------------

            // Create the <a> link here
            var link = document.createElement("A");
            link.id = dpageName;
            link.className = "links";
            link.setAttribute("href",currentStorage);
            var linknode = document.createTextNode(dpageName);
            link.appendChild(linknode);
            // ------------------------
            // Create a temporary div element to attach the a elem so we can grab the full html
            var tmp = document.createElement("div");
            tmp.appendChild(link); // Attach the a elem to the div elem
            var duhClass = document.getElementsByClassName(dpageName); // Find the li elem
            duhClass[0].innerHTML = tmp.innerHTML;
            var idholder = dpageName + "img";

            // Attach our image( little x ) to allow click for removal functionality
            $("."+dpageName).append($("<img>", { // Append to the li elem
                id : idholder,
                class : "deletes",
                src : "/servlet/servlet.FileDownload?file=00P1I000001nhgBUAQ",
                width : 12,
                height : 12
            }));

        }
    }

    // Remove the item from the bookmarks menu
    $(".deletes").on("click", function(){
        var target = event.target.id;
        target = target.split("img")[0]; // Remove the img off of the id from the image
        $("li."+target).remove(); // using that delete the element

        // Need to remove item from storage now
        var testmark = JSON.parse(localStorage.getItem("bookmarks"));
        for(var i = 0; i < testmark.length; i++) {
            var tester = testmark[i].includes(target);
            if( tester == true) {
                testmark.splice(i,1); // Remove from list
                localStorage.setItem("bookmarks", JSON.stringify(testmark)); // Push in the new array
                break;
            }
        }
    });

}
// ------------------------------- End Function -------------------------------------




// ----------------------- Everything below here is old page code used for testing ---------------
/*

//-------------------- Make the bookmarks in the nav not show up ------------------
var placeholder = document.getElementsByClassName("bookmarks_m_class");
var newUL = placeholder[0];
newUL.style = "none";
//---------------------------------------------------------------------------------
// ---------- Playing with items in storage -----------
console.log("items in storage: " + localStorage.length);
console.log( localStorage.key(0));
console.log( localStorage.key(1));
console.log( localStorage.getItem("' + pageName + '"));
console.log( localStorage.getItem("' + pageName + '1"));
console.log( localStorage.getItem("' + pageName + 'Url"));
var me  = JSON.parse(localStorage.getItem("' + pageName + '")); // Parse back to pull into new object
console.log( me );
console.log( me.pageStatus); // Call individual parts of an object by their key name
//--------------------------------------------------------------------

// ---------- Checking Storage ----------
// ---------- Local ----------
<button id="checker" type = "button"> Check local Storage </button> <-- This must be created in the html ---->

document.getElementById("checker").addEventListener("click",function(){
    for(var i =0; i < localStorage.length; i++){
        console.log(localStorage.getItem(localStorage.key(i)));' +
    }
});
//-----------------------------------------------
// ---------- Parsed ----------
<button id="tester" type = "button"> Check parsed Storage </button> <-- This must be created in the html ---->

document.getElementById("tester").addEventListener("click",function(){
    var display = JSON.parse(localStorage.getItem("bookmarks"));
    console.log(display);
    console.log(display[1]);
});
//-----------------------------------------------

*/

