global virtual with sharing class KevansContentTemplate extends cms.ContentTemplateController {
  global KevansContentTemplate(cms.CreateContentController cc) {
    super(cc);
  }
  
  global KevansContentTemplate() {}
  
  public String tTitle {
    get {
      return(this.getProperty('tTitle'));
    }
  }

  public String tName {
    get {
      return(this.getProperty('tName'));
    }
  }

  public String tCompany {
    get {
      return(this.getProperty('tCompany'));
    }
  }

  public String tWebsite {
    get {
      return(this.getProperty('tWebsite'));
    }
  }

  public String tLink {
    get {
      return(this.getProperty('tLink'));
    }
  }

  public String tQuote {
    get {
      return(this.getProperty('tQuote'));
    }
  }

  public String imageUrl {
    get {
      return (this.getProperty('imageUrl'));
    }
  }
  
  global virtual override String getHTML() {
    String html = '';
    html += '<div class="testimonialWrapper">';
    html += '<img src="' + imageUrl + '" height="300" width="300">';
    html += '<div class="titleClass">' + tTitle + '</div>';
    html += '<div class="nameClass">' + tName + '</div>';
    html += '<div class="companyClass">' + tCompany + '</div>';
    html += '<div class="websiteClass">' + '<a href="' + tLink + '">' + tWebsite + '</a> </div>';
    html += '<div class="quoteClass">' + '<blockquote>' + tQuote + '</blockquote>' + '</div>';
    html += '</div>';
    return html;
  }


}