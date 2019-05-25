/**
 * Created by kevanrayner on 2017-11-23.
 */
//Controller

global virtual with sharing class bookmarkIconclass extends cms.ContentTemplateController {
    global bookmarkIconclass(cms.CreateContentController cc) {
        super(cc);
    }

    public string pageName{get;set;}
    public string urlValue{get;set;}

    global bookmarkIconclass() {
        pageName = ApexPages.currentPage().getUrl(); // Pulls the Url with the name in
        pageName = pageName.split('name=')[1]; // Splits to find what comes just after name=
        pageName = pageName.split('&')[0];  // Gets just the name ( & is the first following character of name )

        urlValue = ApexPages.currentPage().getUrl(); // Allows redirects to this page
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


    //Does nothing just here for remote action referenceing later
    @RemoteAction
    global static String IwannaSave() {
        return 'Hey';
    }


    global virtual override String getHTML() {
        String html = '';

        html += '<img id="theBookmark" src=' + ImageUrl + ' style="display: inline-block;"/>';
        //------------------------------------------------------------------------------------
        //--------------------- Do stuff on page initialization ( check page status) ---------
        html += '<script>' + // Run function --- Send apex page data that you need ------
                'BookmarkInit("' + urlValue + '","' + ImageUrl + '","' + selectedImageUrl + '")' +
                '</script>';
        //------------------------------------------------------------------------------------

        return html;
    }
}
