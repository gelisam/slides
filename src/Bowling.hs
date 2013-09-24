-- mutable callback
$.ajax("http://google.com?q=haskell",
  function(response) {
    p = $("#results_pane");
    setContents(p, response);
  }
);

-- immutable callback?
$.ajax("http://google.com?q=haskell",
  function(response) {
    -- no way to affect the program
    -- from here...
  }
);
