/**
 * Created by kevanrayner on 2017-11-23.
 */
//Controller

global virtual with sharing class bmCatcherclass extends cms.ContentTemplateController {
    global bmCatcherclass(cms.CreateContentController cc) {
        super(cc);
    }

    public string urlvalue{get;set;}


    global bmCatcherclass() {
        urlvalue = ApexPages.currentPage().getUrl(); // Allows redirects to this page
        }


    @RemoteAction
    global static String ClearTheStorage() {
        return 'localStorage.clear();';
    }


    global virtual override String getHTML() {
        String html = '';
        //----------------------------------------------
        html += '<br/>';
        html += '<div>';
        html += '<p id="bookmarksp" style="display:inline">';
        html += 'Bookmarks:';
        html += '</p>';
        html += '<button id="cleaner" type = "button" style="display:inline;margin-left:1em"> Clear local Storage </button>' +
                '<script>' +
                'document.getElementById("cleaner").addEventListener("click",function(){' +
                ClearTheStorage() +
                '});' +
                '</script>';
        //-----------------------------------------------
        //html += '<button id="checker" type = "button"> Check local Storage </button>' +
                //'<script>' +
                //'document.getElementById("checker").addEventListener("click",function(){' +
               // 'for(var i =0; i < localStorage.length; i++){' +
               // 'console.log(localStorage.getItem(localStorage.key(i)));' +
               // '}' +
              //  '});' +
              //  '</script>';
        //-----------------------------------------------
        //html += '<button id="tester" type = "button"> Check parsed Storage </button>' +
                //'<script>' +
                //'document.getElementById("tester").addEventListener("click",function(){' +
               // 'var display = JSON.parse(localStorage.getItem("bookmarks"));' +
                //'console.log(display);' +
               // 'console.log(display[1]);' +
               // '});' +
               // '</script>';
        //-----------------------------------------------
        html += '</div>';
        //-----------------------------------------------
        html += '<ul id="myList">';

        //----------------------------------------------
        html += '<script>' +
                'if (localStorage.getItem("bookmarks") != null) {' + // Check if there is anything in storage'
                    'var pullStorage = JSON.parse(localStorage.getItem("bookmarks"));' +
                    'var storageLength = pullStorage.length;' + // var for num of items


                // Loop through the items in storage
                    'for(var i = 0; i < storageLength; i++) {' + // Cant use the local storage length - Need to parse into

                        // Constants we will need later in this loop
                        'var currentStorage = pullStorage[i];' +
                        'var dpageName = currentStorage;' + // Pulls the Url with the name in
                        'dpageName = dpageName.split("name=")[1];' + // Splits to find what comes just after name=
                        'dpageName = dpageName.split("&")[0];' +  // Gets just the name ( & is the first following character of name )

                        'var place = document.getElementsByClassName("leftColumn");' + // Create the object
                        'var anode = place[0];' + // that directs to the webpage
                        //---------------------------------

                        // Create the list element
                        'var node = document.createElement("LI");' +
                        'node.id = "linkButtons";' +
                        'node.className = dpageName;' +
                        'var textnode = document.createTextNode("Button" + i );' +
                        'node.appendChild(textnode);' +
                        'document.getElementById("myList").appendChild(node);' + // Add it to the page


                        // Creates the <a> link here
                        'var link = document.createElement("A");' +
                        'link.id = dpageName;' +
                        'link.className = "links";' +
                        'link.setAttribute("href",currentStorage);' +
                        'var linknode = document.createTextNode(dpageName);' +
                        'link.appendChild(linknode);' + // Attach the visual display to the link
                        //'anode.appendChild(link);' +

                        'var tmp = document.createElement("div");' +
                        'tmp.appendChild(link);' +

                        'var duhClass = document.getElementsByClassName(dpageName);' +
                        'duhClass[0].innerHTML = tmp.innerHTML;' +

                        'var idholder = dpageName + "img";' +

                        '$("."+dpageName).append($("<img>", { ' +
                            'id : idholder,' +
                            'class : "deletes",' +
                            'src : "/servlet/servlet.FileDownload?file=00P1I000001nhgBUAQ",' +
                            'width : 12,' +
                            'height : 12,' +
                        '}));' +



                        //'var a = document.getElementById("yourlinkId");' +
                        //'a.href = "somelink url"' +

                        //'var newbtn = document.createElement("button");' + // array first then use that length with those
                        //'newbtn.id="Button" + i;' +
                        //'var test = document.createTextNode("Button" + i);' + // elements as the links and text
                        //'newbtn.appendChild(test);' + // Attach what the button is gonna say

                        //'anode.appendChild(newbtn);' + // Push into the webpage
                     '}' +
                '}' +
                '</script>';
        //-----------------------------------------------
        html += '</ul>';
        //-----------------------------------------------
        // Function for removing an item from the bookmarked list
        html += '<script>';
        html += '$(".deletes").on("click", function(){' +
                    'var target = event.target.id;' +
                    'target = target.split("img")[0];' +
                    //'console.log("Hello " + target);' +
                    '$("li."+target).remove();'; // Remove the link

                // If bookmarks exists ( something exists we dont know what )
                html += 'var testmark = JSON.parse(localStorage.getItem("bookmarks"));';
                html += 'for(var i = 0; i < testmark.length; i++) {' ;
                        html += 'var tester = testmark[i].includes(target);'; // Check if the current page is there
                        html += 'if( tester == true) {';
                            html += 'testmark.splice(i,1);' +
                            'localStorage.setItem("bookmarks", JSON.stringify(testmark));' +
                            'break;';
                        html += '};';
                html += '};';
        html += '});';
        html += '</script>';


        // Place were all the bookmarked buttons will be

        return html;
        }
}