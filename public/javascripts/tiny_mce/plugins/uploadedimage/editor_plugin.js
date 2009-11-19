(function() {
	tinymce.create('tinymce.plugins.UploadedImagePlugin', {
		init : function(ed, url) {
			// Register commands
			ed.addCommand('mceUploadedImage', function() {
				// Internal image object like a flash placeholder
				if (ed.dom.getAttrib(ed.selection.getNode(), 'class').indexOf('mceItem') != -1)
					return;

				ed.windowManager.open({
					file : url + '/image.htm',
					width : 480 + parseInt(ed.getLang('advimage.delta_width', 0)),
					height : 385 + parseInt(ed.getLang('advimage.delta_height', 0)),
					inline : 1
				}, {
					plugin_url : url
				});
			});

			// Register buttons
			ed.addButton('image', {
				title : 'advimage.image_desc',
				cmd : 'mceUploadedImage'
			});
		},

		getInfo : function() {
			return {
				longname : 'Uploaded Images',
				author : 'launersoft',
				authorurl : 'http://www.launersoft.com.ar',
				infourl : 'http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/advimage',
				version : tinymce.majorVersion + "." + tinymce.minorVersion
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('uploadedimage', tinymce.plugins.UploadedImagePlugin);
})();