/**
 * Created by kevanrayner on 2018-03-22.
 */

global virtual with sharing class blog_loaderclass extends cms.ContentTemplateController {
    global blog_loaderclass(cms.CreateContentController cc) {
        super(cc);
    }

    global blog_loaderclass() {}


    global virtual override String getHTML() {
        String html = '';
        html += 'Hello World';

        html += '<script>' +
                'loadBlogPageTaxonomy();' +
                '</script>';

        return html;
    }

}