!function(t){"use strict";t.ajaxPrefilter(function(t){return t.iframe?"iframe":void 0}),t.ajaxTransport("iframe",function(e,a,n){function r(){l.prop("disabled",!1),o.remove(),d.bind("load",function(){d.remove()}),d.attr("src","javascript:false;")}var i,o=null,d=null,u="iframe-"+t.now(),s=t(e.files).filter(":file:enabled"),l=null;return e.dataTypes.shift(),s.length?(o=t("<form enctype='multipart/form-data' method='post'></form>").hide().attr({action:e.url,target:u}),"string"==typeof e.data&&e.data.length>0&&t.error("data must not be serialized"),t.each(e.data||{},function(e,a){t.isPlainObject(a)&&(e=a.name,a=a.value),t("<input type='hidden' />").attr({name:e,value:a}).appendTo(o)}),t("<input type='hidden' value='IFrame' name='X-Requested-With' />").appendTo(o),i=e.dataTypes[0]&&e.accepts[e.dataTypes[0]]?e.accepts[e.dataTypes[0]]+("*"!==e.dataTypes[0]?", */*; q=0.01":""):e.accepts["*"],t("<input type='hidden' name='X-Http-Accept'>").attr("value",i).appendTo(o),l=s.after(function(){return t(this).clone().prop("disabled",!0)}).next(),s.appendTo(o),{send:function(e,a){d=t("<iframe src='javascript:false;' name='"+u+"' id='"+u+"' style='display:none'></iframe>"),d.bind("load",function(){d.unbind("load").bind("load",function(){var t=this.contentWindow?this.contentWindow.document:this.contentDocument?this.contentDocument:this.document,e=t.documentElement?t.documentElement:t.body,i=e.getElementsByTagName("textarea")[0],o=i&&i.getAttribute("data-type")||null,d=i&&i.getAttribute("data-status")||200,u=i&&i.getAttribute("data-statusText")||"OK",s={html:e.innerHTML,text:o?i.value:e?e.textContent||e.innerText:null};r(),n.responseText||(n.responseText=s.text),a(d,u,s,o?"Content-Type: "+o:null)}),o[0].submit()}),t("body").append(o,d)},abort:function(){null!==d&&(d.unbind("load").attr("src","javascript:false;"),r())}}):void 0})}(jQuery),function(t){var a;t.remotipart=a={setup:function(e){e.one("ajax:beforeSend.remotipart",function(n,r,i){return delete i.beforeSend,i.iframe=!0,i.files=t(t.rails.fileInputSelector,e),i.data=e.serializeArray(),i.processData=!1,void 0===i.dataType&&(i.dataType="script *"),i.data.push({name:"remotipart_submitted",value:!0}),t.rails.fire(e,"ajax:remotipartSubmit",[r,i])&&t.rails.ajax(i),a.teardown(e),!1}).data("remotipartSubmitted",!0)},teardown:function(t){t.unbind("ajax:beforeSend.remotipart").removeData("remotipartSubmitted")}},t(document).on("ajax:aborted:file","form",function(){var n=t(this);return a.setup(n),!t.support.submitBubbles&&t().jquery<"1.7"&&t.rails.callFormSubmitBindings(n)===!1?t.rails.stopEverything(e):(t.rails.handleRemote(n),!1)})}(jQuery);