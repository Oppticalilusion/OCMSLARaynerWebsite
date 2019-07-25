/**
 * Created by kevanrayner on 2018-02-16.
 */

global virtual with sharing class cm_loaderclass extends cms.ContentTemplateController {
    global cm_loaderclass(cms.CreateContentController cc) {
        super(cc);
    }

    global cm_loaderclass() {
        }

    global virtual override String getHTML() {
        String html = '';
        html += '<script>' +
                //'grabByName();' + // Working Example (Filtering API) - By ContentName
                //'doRender();' + // Working Example (Rendering API) - By ContentName
                //'doNewTaxRender();' + // Actual example class shown on developer.stantive
                //'doTaxonomy();' + // Pulls few pieces of content for taxonomy loader example
                //'doNewTax();' + // Pulls different content types and outputs to console the bundle
                'doNewTaxFinalStep();' +
                '</script>';
        html += '<div class="taxonomyWrapper">' +
                '</div>';

        return html;
    }

}

// What follows is an example of using Apex to grab content by taxonomy
// Will only pull one piece interestingly enough
// So just use javascript cause that works and makes more sense structurally
// Sorry apex
// If you want to run this move into the cm_loaderclass and open up a
// salesforce developer console for output

/*
List<String> tagPaths = new List<String>();
        tagPaths.add('/testRoot/level1');

        RenderingAPIRequest renderingRequest = new RenderingAPIRequest();
        renderingRequest.parameters.put('renderType', 'taxonomy');
        renderingRequest.listParameters.put('contentTypes', new List<String>{'Text','Media'});
        renderingRequest.listParameters.put('tagPaths', tagPaths);

        List<String> layoutsForTaxonomy = new List<String>{'TextBlock','Image','TextBlock'};
        renderingRequest.layoutsForTaxonomy = new List<List<String>>{layoutsForTaxonomy};

        Map<String, String> parameters = new Map<String, String>();
        parameters.put('renderingRequest', json.serialize(renderingRequest));
        parameters.put('action', 'getRenderedContent');
        parameters.put('service', 'OrchestraRenderingAPI');
        parameters.put('sname', 'burford'); // Replace site_name with the name of your OrchestraCMS site
        parameters.put('application', 'runtime');
        parameters.put('apiVersion', '5.0');

        String response = cms.ServiceEndpoint.doActionApex(parameters);
        JSONMessage.APIResponse apiResponse = (JSONMessage.APIResponse) json.deserialize(response, JSONMessage.APIResponse.class);


//if (!apiResponse.isSuccess)
       // throw new APIException('Could not retrieve renderings for this node');
      //  if (apiResponse.type != 'RenderResultBundle')
        //    throw new APIException('Unexpected result from Rendering API');

        // Obviously we dont want this to be null
        System.Debug(apiResponse);
        System.Debug(apiResponse.responseObject); // Returns a RenderResultBundle


        // New stuff trying here
        RenderResultBundle resultBundle = (RenderResultBundle) json.deserialize(apiResponse.responseObject, RenderResultBundle.class);
        for (RenderResultBundle.RenderedContent renderedContent : resultBundle.renderings) {
            for (String rendering : renderedContent.renderMap.values()) {
                System.Debug(rendering);
            }
        }
 */