/**
 * Created by kevanrayner on 2017-11-23.
 */
//Controller

global virtual with sharing class bmCatcherclass extends cms.ContentTemplateController {
    global bmCatcherclass(cms.CreateContentController cc) {
        super(cc);
    }

    public string urlValue{get;set;}


    global bmCatcherclass() {
        urlValue = ApexPages.currentPage().getUrl(); // Allows redirects to this page
        }


    @RemoteAction
    global static String ClearTheStorage() {
        return 'localStorage.clear();';
    }


    global virtual override String getHTML() {
        String html = '';
        //----------------------------------------------
        html += '<br/>';

        html += '<script>' +
                'BCatcherInit();' +
                '</script>';
        //-----------------------------------------------


        return html;
        }
}
