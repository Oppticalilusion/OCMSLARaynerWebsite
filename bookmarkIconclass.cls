/**
 * Created by kevanrayner on 2017-11-23.
 */
//Controller

global virtual with sharing class bookmarkIconclass extends cms.ContentTemplateController {
    global bookmarkIconclass(cms.CreateContentController cc) {
        super(cc);
    }

    public string pageName{get;set;}
    public string urlvalue{get;set;}

    global bookmarkIconclass() {
        pageName = ApexPages.currentPage().getUrl(); // Pulls the Url with the name in
        pageName = pageName.split('name=')[1]; // Splits to find what comes just after name=
        pageName = pageName.split('&')[0];  // Gets just the name ( & is the first following character of name )

        urlvalue = ApexPages.currentPage().getUrl(); // Allows redirects to this page
    }

    //Image Selector
    public String ImageUrl {
        get {
            return this.getProperty('ImageUrlSample');
        }

    }

    public String selectedImageUrl {
        get {
            return this.getProperty('ImageSelected');
        }
    }


    //Does nothing just here for remoteaction referenceing later
    @RemoteAction
    global static String IwannaSave() {
        return 'Hey';
    }


    global virtual override String getHTML() {
        String html = '';

        //html += '<div class="playgroundWrapper">';

        html += '<img id="theBookmark" src=' + ImageUrl + ' style="display: inline-block;"/>';
        //----------------------------------------------------------------------
        //--------------------- Do stuff on page initialization ( check page status)
        html += '<script>' +
                'if (localStorage.getItem("bookmarks") === null) {' +
                    'var bookmarks = [];' +
                '} else {' +
                    'var bookmarks = JSON.parse(localStorage.getItem("bookmarks"));' +
                '}' +
                '</script>';

        //--------------------- Set the image of the bookmark based on page status
        html += '<script>' +
                //'if(localStorage.getItem( "' + pageName + '" ) == "notbookmarked" ) {' + // Check if page is bookmarked
                'if(bookmarks.includes("' + urlvalue + '")) {' +
                    'document.getElementById("theBookmark").src="' + selectedImageUrl + '";' +
                    'console.log("Should be bookmarked");' +
                '} else {' +
                    'document.getElementById("theBookmark").src="' + ImageUrl + '";' +
                    'console.log("Should be un-bookmarked");' +
                '}' +
                '</script>';

        //----------------------------------------------------------------------
        //------------------------------

        html += '<script>';

        //If else ladder to determine which bookmark state to display for now
        //  ------------ Event to change the state of the bookmark ----------------------------
        html += '$("#theBookmark").on("click", function(){';

            html += 'if (localStorage.getItem("bookmarks") != null) {'; // Check if there is anything in storage

                // If bookmarks exists ( something exists we dont know what )
                html += 'var testbookmark = JSON.parse(localStorage.getItem("bookmarks"));';
                html += 'var tester = testbookmark.includes("' + urlvalue + '");'; // Check if the current page is there

                html +=  'if( tester == true) {';
                    // Url exists in bookmarks array
                    html += 'var removed = JSON.parse(localStorage.getItem("bookmarks"));'; // Remove from localStorage list
                    html += 'for (var i=0; i< removed.length; i++) {' +
                                'console.log("We are running test " + i);' +
                                'var url = "' + urlvalue + '";' +
                                'if(url === removed[i]) {' +
                                    'removed.splice(i,1);' +
                                    'localStorage.setItem("bookmarks", JSON.stringify(removed));' +
                                    'console.log("Deleted item number " + i + " from the list");' +
                                    'break;' +
                                '}' +
                            '}' ;
                    html += 'document.getElementById("theBookmark").src="' + ImageUrl + '";'; // Un-Bookmark page

                html += '} else {' +
                    // Url does not exist in bookmarks array
                    'var stored = JSON.parse(localStorage.getItem("bookmarks"));' +
                    'var mark = "' + urlvalue + '";' +
                    'stored.push(mark);' +
                    'localStorage.setItem("bookmarks", JSON.stringify(stored));' +
                    'document.getElementById("theBookmark").src="' + selectedImageUrl + '";' + // Bookmark page

                '}';

            html += '} else {' + // List is empty

                'var stored = [];' + // Push url of page into bookmarks array
                'var mark = "' + urlvalue + '";' +
                'stored.push(mark);' +
                'localStorage.setItem("bookmarks", JSON.stringify(stored));' +
                'document.getElementById("theBookmark").src="' + selectedImageUrl + '";' + // Bookmark page
             '}';
        html += '});'; // Close Event Listener Function
        html += '</script>';
        //------------------------------------------------------------------------
        //---------------------------------------------------------------------
        //Playing with items in storage
        //html += '<script>' +
                //'console.log("items in storage: " + localStorage.length);' +
            //   'console.log( localStorage.key(0));' +
            //    'console.log( localStorage.key(1));' +
           //     'console.log( localStorage.getItem("' + pageName + '"));' +
           //     'console.log( localStorage.getItem("' + pageName + '1"));' +
           //     'console.log( localStorage.getItem("' + pageName + 'Url"));' +
          //      'var me  = JSON.parse(localStorage.getItem("' + pageName + '"));' + // Parse back to pull into new object
         //       'console.log( me );' +
         //       'console.log( me.pageStatus);' + // Call individual parts of an object by their key name
                //'</script>';


        //------------------------------------------------------------------------
        //-----------------------------------------------------------------------
        //html += '</div>';  // Close the javascript playground for the bookmark element
        return html;
    }
}
