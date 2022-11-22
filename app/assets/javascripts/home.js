var googletag = googletag || {};
googletag.cmd = googletag.cmd || [];

googletag.cmd.push(function() {
  // GPT slots de 960x90 y 728x90
  var mapping = googletag.sizeMapping().
  addSize([0, 0], [320, 50]).
  addSize([1000, 400], [960, 90]).
  build();
  googletag.defineSlot('/1479013/ocasas_contenido', [[320, 50], [728, 90], [960, 90]], 'div-gpt-ad-1503513918839-1').defineSizeMapping(mapping).addService(googletag.pubads());
  var mapping = googletag.sizeMapping().
  addSize([0, 0], [320, 50]).
  addSize([780, 400], [728, 90]).
  addSize([1000, 400], [728, 90]).
  build();
  googletag.defineSlot('/1479013/ocasas_pie', [[320, 50], [728, 90]], 'div-gpt-ad-1503513918839-6').defineSizeMapping(mapping).addService(googletag.pubads());
  // GPT slots de 300x250
  var mapping = googletag.sizeMapping().
  addSize([0, 0], [300, 250]).
  addSize([780, 400], [300, 250]).
  addSize([1000, 400], [300, 250]).
   build();
  googletag.defineSlot('/1479013/ocasas_destacado_1', [[320, 50], [300, 250]], 'div-gpt-ad-1503513918839-2').defineSizeMapping(mapping).addService(googletag.pubads());
  var mapping = googletag.sizeMapping().
  addSize([0, 0], [300, 250]).
  addSize([780, 400], [300, 250]).
  addSize([1000, 400], [300, 250]).
  build();
  googletag.defineSlot('/1479013/ocasas_destacado_2', [[320, 50], [300, 250]], 'div-gpt-ad-1503513918839-3').defineSizeMapping(mapping).addService(googletag.pubads());
  var mapping = googletag.sizeMapping().
  addSize([0, 0], [300, 250]).
  addSize([780, 400], [300, 250]).
  addSize([1000, 400], [300, 250]).
  build();
  googletag.defineSlot('/1479013/ocasas_destacado_3', [[320, 50], [300, 250]], 'div-gpt-ad-1503513918839-4').defineSizeMapping(mapping).addService(googletag.pubads());
  googletag.defineSlot('/1479013/ocasas_layer', [1, 1], 'div-gpt-ad-1503513918839-5').addService(googletag.pubads());
  googletag.pubads().enableSingleRequest();
  googletag.pubads().collapseEmptyDivs();
  googletag.pubads().setTargeting('TipoPagina', ['Portada']);
  googletag.enableServices();
});
