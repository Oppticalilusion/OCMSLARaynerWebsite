/**
 * Created by kevanrayner on 2018-03-08.
 */


    global virtual with sharing class CustomResourcesTemplate extends cms.ContentTemplateController {
        global CustomResourcesTemplate(cms.CreateContentController cc) {
            super(cc);
        }

        global CustomResourcesTemplate() {}

        public String rTitle {
            get {
                return(this.getProperty('rTitle'));
            }
        }

        public String rList {
            get {
                return(this.getProperty('rList'));
            }
        }


        global virtual override String getHTML() {
            String html = '';
            html += '<div class="resourceWrapper">';
            html += '<div class="titleClass">' + rTitle + '</div>';
            html += '<div class="listClass">' + rList + '</div>';
            html += '</div>';
            return html;
        }


}