/**
 * Created by kevanrayner on 2018-03-22.
 */

global virtual with sharing class ArticleBlockFullClass extends cms.ContentTemplateController {
    global ArticleBlockFullClass(cms.CreateContentController cc) {
        super(cc);
    }

    global ArticleBlockFullClass() {}


    public String artTitle {
        get {
            return(this.getProperty('artTitle'));
        }
    }

    public String artAuthor {
        get {
            return(this.getProperty('artAuthor'));
        }
    }

    public String artContent {
        get {
            return(this.getProperty('artContent'));
        }
    }


    global virtual override String getHTML() {
        String html = '';
        html += '<div class="Article_Block">';
        html += '<div class="Article_Title">' + artTitle + '</div>';
        html += '<div class="Article_Content">' + artContent + '</div>';

        html += '</div>';
        return html;
    }

}