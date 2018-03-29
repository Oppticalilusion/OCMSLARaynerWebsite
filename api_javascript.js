// Javascript file that holds the functions created for api use
// Playing with the filtering and rendering api with the ultimate goal of building my own taxonomy loader
//-----------------------------------------------------------------------------
// Filtering api
// Grabs a piece of content by its name and returns a FilteringBundle with it's information
// Bundle is logged to the console for display purposes
function grabByName() {
    var listparams = {
        contentNames: ['Testimonials_created_1'] // Name of content to grab
    };
    var filteringRequest = {
        listParameters: listparams,
        requestFlags: {}
    };
    var response; // Used to get the JSON Object Response from action
    var data = {
        service: 'FilteringAPI',
        action: 'getContentByName',
        filteringRequest: JSON.stringify(filteringRequest),
        apiVersion: '5.0'
    };
// Handle response of a successful ajax call
    var ccallBackHandler = function(json, Success) {
        console.log("Filtering api grab by name: grabByName(): ");
        console.log(json);
        response = JSON.parse(json);
    }
    var options = {
        cb: ccallBackHandler,
        cbHandlerOnComplete: function(textStatus) { console.log("Done names"); // Handle response on complete
                                                    console.log("-------------------------------------");},
        readonly: true // Whether it is a read only call
    };
    doServiceRequest(data, options);

}
//-----------------------------------------------------------------------------
// Rendering api used
// Grabs a piece of content by name and returns a RenderResultsBundle with it's information
// Logged to console for display purposes
function doNewTaxRender() {
    var listparams = {
        contentNames: ['abc'],
        contentLayouts: ['TextBlock']
    };
    var params = {
        renderType: 'contentName'
    };
    var renderingRequest = {
        listParameters: listparams,
        parameters: params,
        requestFlags: {}
    };
    var response; // Used to get the JSON Object Response from action
    var data = {
        service: 'OrchestraRenderingAPI',
        action: 'getRenderedContent',
        renderingRequest: JSON.stringify(renderingRequest),
        apiVersion: '5.0'
    };
// Handle response of a successful ajax call
    var callBackHandler = function(json, Success) {
        console.log("Rendering api grab by content name ( NEW TAX ) doNewTaxRender(): ");
        console.log(json);
        response = JSON.parse(json);
    }
    var options = {
        cb: callBackHandler,
        cbHandlerOnComplete: function(textStatus) {console.log("Done the rendering by name"); // Handle response on complete
            console.log("-------------------------------------");},
        readonly: true // Whether it is a read only call
    };
    doServiceRequest(data, options);
}
//-----------------------------------------------------------------------------
// The exact same as above just using a different template(layout) and type
function doRender() {
    var listparams = {
        contentNames: ['Testimonials_created_1'],
        contentLayouts: ['Testimonials_t_written']
    };
    var params = {
        renderType: 'contentName'
    };
    var renderingRequest = {
        listParameters: listparams,
        parameters: params,
        requestFlags: {}
    };
    var response; // Used to get the JSON Object Response from action
    var data = {
        service: 'OrchestraRenderingAPI',
        action: 'getRenderedContent',
        renderingRequest: JSON.stringify(renderingRequest),
        apiVersion: '5.0'
    };
// Handle response of a successful ajax call
    var callBackHandler = function(json, Success) {
        console.log("Rendering api grab by content name: doRender(): ");
        console.log(json);
        response = JSON.parse(json);
    }
    var options = {
        cb: callBackHandler,
        cbHandlerOnComplete: function(textStatus) {console.log("Done the rendering by name"); // Handle response on complete
                                                   console.log("-------------------------------------");},
        readonly: true // Whether it is a read only call
    };
    doServiceRequest(data, options);
}
//-----------------------------------------------------------------------------
// Attempting to pull info based on taxonomy tag
// Using the rendering api
// Using a basic example to create functionality of the taxonomy loader
// Pulls 2 basic pieces of content from tiny taxonomy tree
function doTaxonomy() {

    var listparams = {
        tagPaths: ['/Taxonomy_Testimonials/level1'], // determines where to start looking for content
        contentTypes: ['c_Types'] // If using multiple types : ['c_Types,anotherType']
    };
    var params = {
        renderType: 'taxonomy'
    };
    var renderingRequest = {
        listParameters: listparams,
        parameters: params,
        layoutsForTaxonomy: [['Testimonials_t_written']],
        requestFlags: {}
    };
    var response; // Used to get the JSON Object Response from action
    var tdata = {
        service: 'OrchestraRenderingAPI',
        action: 'getRenderedContent',
        renderingRequest: JSON.stringify(renderingRequest),
        apiVersion: '5.0'
    };
    // Handle response of successful ajax call
    var callBackHandler = function(json, Success) {

        var placeholder = document.getElementsByClassName("taxonomyWrapper");
        var taxDiv = placeholder[0]; // Find the div we are pushing the content into

        console.log("Rendering api initial attempt: doTaxonomy(): ");
        console.log(json);
        response = JSON.parse(json);
        var nResponse = JSON.parse(response.responseObject);

        var numItems = nResponse.renderings.length; // Get the number of items found
        for(var i = 0; i < numItems; i++) {
            // Grab each piece of content 1 at a time then push onto the page
            var anotherResp = nResponse.renderings[i].renderMap;
            var finalResp = anotherResp.Testimonials_t_written; // layout used in call
            taxDiv.innerHTML += finalResp;
        }
    }
    var toptions = {
        cb: callBackHandler,
        cbHandlerOnComplete: function(textStatus) { console.log("Complete"); // Handle response on complete
                                                    console.log("-------------------------------------");},
        readonly: true
    };
        doServiceRequest(tdata, toptions);
}
//-----------------------------------------------------------------------------
// Attempting to use a new taxonomy structure called :  tax_load_structure
// The total path of the structure is : /tax_load_structure/Text/Images/Custom
// text - Text Block : Images - Small Block with Image : Custom - Testimonials_t_written
function doNewTax() {
    var listparams = { // Full path -> /tax_load_structure/Text/Images/Custom
        tagPaths: ['/tax_load_structure/Text'],
        contentTypes: ['Text','c_Types']
    };
    var params = {
        renderType: 'taxonomy'
    };
    var renderingRequest = {
        listParameters: listparams,
        parameters: params,
        layoutsForTaxonomy: [['TextBlock'],['SmallBlockWithImage'],['new_t_written']], // [Text/Images]
        requestFlags: {}
    };
    var response; // Used to get the JSON Object Response from action
    var data = {
        service: 'OrchestraRenderingAPI',
        action: 'getRenderedContent',
        renderingRequest: JSON.stringify(renderingRequest),
        apiVersion: '5.0'
    };
    // Handle response of successful ajax call
    var callBackHandler = function(json, Success) {
        console.log("New Taxonomy Attempt: doNewTax(): ");
        console.log(json);
        response = JSON.parse(json);
        console.log("The response only object is as follows: ---------------");
        console.log(response.responseObject);
    }
    var options = {
        cb: callBackHandler,
        cbHandlerOnComplete: function(textStatus) { console.log("Complete"); // Handle response on complete
                                                    console.log("-------------------------------------");},
        readonly: true
    };
    doServiceRequest(data, options);
}
//-----------------------------------------------------------------------------
// Attempting to pull multiple different contentTypes and display them on the page
// Custom taxonomy loader
// Using     /tax_load_structure/Text/Images/Custom        taxonomy tree [ FULL PATH ]
// Used on the c_Testimonials page   - Loads in order of most recently updated
function doNewTaxFinalStep() {
    var listparams = { // Full path -> /tax_load_structure/Text/Images/Custom
        tagPaths: ['/tax_load_structure/Text/Images/Custom'],
        contentTypes: ['Text','c_Types']
    };
    var params = {
        renderType: 'taxonomy'
    };
    var renderingRequest = {
        listParameters: listparams,
        parameters: params,
        layoutsForTaxonomy: [['new_t_written']], // Templates
        requestFlags: {}
    };
    var response; // Used to get the JSON Object Response from action
    var data = {
        service: 'OrchestraRenderingAPI',
        action: 'getRenderedContent',
        renderingRequest: JSON.stringify(renderingRequest),
        apiVersion: '5.0'
    };
    // Handle response of successful ajax call
    var callBackHandler = function(json, Success) {
        var placeholder = document.getElementsByClassName("taxonomyWrapper");
        var taxDiv = placeholder[0]; // Find the div we are pushing the content into

        console.log("New Taxonomy Attempt: doNewTaxFinalStep(): ");
        console.log(json);
        response = JSON.parse(json);
        var nResponse = JSON.parse(response.responseObject);

        var numItems = nResponse.renderings.length; // Get the number of items found
        for(var i = 0; i < numItems; i++) {
            // Grab each piece of content 1 at a time then push onto the page
            var anotherResp = nResponse.renderings[i].renderMap;

            var tester = Object.keys(anotherResp)[0]; // Pulls the name of the layout

            // [data] is the same as .data except it will work as a variable call rather than
            // just looking for if the var name exists inside the object
            taxDiv.innerHTML += anotherResp[tester]; // layout used in call
        }
    }
    var options = {
        cb: callBackHandler,
        cbHandlerOnComplete: function(textStatus) { console.log("Complete"); // Handle response on complete
                                                    console.log("-------------------------------------");},
        readonly: true
    };
    doServiceRequest(data, options);
}
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------