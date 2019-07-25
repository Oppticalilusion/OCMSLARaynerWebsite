// Javascript file that holds the functions created for blog use

/*-----------------------------------------------------------------------------*/
// Function called on page load
// Split into 2 parts
//      First part being the initial article load
//      Second part being the right side "navigation" load

/*
    Grabs the 10 most recently published pieces of content in the taxonomy
    Display them on page in descending order
        All following the first will be shown in miniaturized versions
    Load in the right hand side of the page
        Note: This will never be re written and once loaded should not be done again

 */

function loadBlogPageTaxonomy() {

    var listparams = {
        tagPaths: ['/blog_taxonomy/Accounting Issues'], // determines where to start looking for content
        contentTypes: ['c_Types'] // If using multiple types : ['c_Types,anotherType']
    };
    var params = {
        renderType: 'taxonomy'
    };
    var renderingRequest = {
        listParameters: listparams,
        parameters: params,
        layoutsForTaxonomy: [['Article_Block_Full']],
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

        var placeholder = document.getElementsByClassName("leftColumn");
        var taxDiv = placeholder[0]; // Find the div we are pushing the content into

        console.log("Ultimate First Test");
        //console.log(json);
        response = JSON.parse(json);
        //console.log(response);
        var nResponse = JSON.parse(response.responseObject);
        console.log(nResponse);


        var numItems = nResponse.renderings.length; // Get the number of items found
        for(var i = 0; i < numItems; i++) {
            // Grab each piece of content 1 at a time then push onto the page
            var anotherResp = nResponse.renderings[i].renderMap;

            console.log(anotherResp);

            var thefinalResp = anotherResp.value;

            console.log("This is a test");

            console.log(thefinalResp);

            var finalResp = anotherResp.Article_Block_Full; // layout used in call

            //console.log(finalResp);

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


/*-----------------------------------------------------------------------------*/



// Function called on recent posts link press

/*
    Sends the content title to the function
    Searches through the taxonomy structure for that piece of content
    Loads it onto the page as the only data ( left side column )
    Adds buttons for menuverability between most recent articles
 */

/*-----------------------------------------------------------------------------*/
// Function called on topics

/*
    Send taxonomy tag path to the function
    Searches for all articles that exist under that tag
    Pulls and displays up to 10 of these onto the page
        Starting from most recently published
        Displaying mini versions of all following content blocks
        Add an older/newer posts button acordingly

    --What's new-- link will be a called to reload the initial blog page
 */
/*-----------------------------------------------------------------------------*/