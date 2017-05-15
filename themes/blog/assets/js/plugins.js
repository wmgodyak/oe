/*jqueryform*/
!function(e){"use strict";"function"==typeof define&&define.amd?define(["jquery"],e):e("undefined"!=typeof jQuery?jQuery:window.Zepto)}(function(e){"use strict";function t(t){var r=t.data;t.isDefaultPrevented()||(t.preventDefault(),e(t.target).ajaxSubmit(r))}function r(t){var r=t.target,a=e(r);if(!a.is("[type=submit],[type=image]")){var n=a.closest("[type=submit]");if(0===n.length)return;r=n[0]}var i=this;if(i.clk=r,"image"==r.type)if(void 0!==t.offsetX)i.clk_x=t.offsetX,i.clk_y=t.offsetY;else if("function"==typeof e.fn.offset){var o=a.offset();i.clk_x=t.pageX-o.left,i.clk_y=t.pageY-o.top}else i.clk_x=t.pageX-r.offsetLeft,i.clk_y=t.pageY-r.offsetTop;setTimeout(function(){i.clk=i.clk_x=i.clk_y=null},100)}function a(){if(e.fn.ajaxSubmit.debug){var t="[jquery.form] "+Array.prototype.join.call(arguments,"");window.console&&window.console.log?window.console.log(t):window.opera&&window.opera.postError&&window.opera.postError(t)}}var n={};n.fileapi=void 0!==e("<input type='file'/>").get(0).files,n.formdata=void 0!==window.FormData;var i=!!e.fn.prop;e.fn.attr2=function(){if(!i)return this.attr.apply(this,arguments);var e=this.prop.apply(this,arguments);return e&&e.jquery||"string"==typeof e?e:this.attr.apply(this,arguments)},e.fn.ajaxSubmit=function(t){function r(r){var a,n,i=e.param(r,t.traditional).split("&"),o=i.length,s=[];for(a=0;o>a;a++)i[a]=i[a].replace(/\+/g," "),n=i[a].split("="),s.push([decodeURIComponent(n[0]),decodeURIComponent(n[1])]);return s}function o(a){for(var n=new FormData,i=0;i<a.length;i++)n.append(a[i].name,a[i].value);if(t.extraData){var o=r(t.extraData);for(i=0;i<o.length;i++)o[i]&&n.append(o[i][0],o[i][1])}t.data=null;var s=e.extend(!0,{},e.ajaxSettings,t,{contentType:!1,processData:!1,cache:!1,type:u||"POST"});t.uploadProgress&&(s.xhr=function(){var r=e.ajaxSettings.xhr();return r.upload&&r.upload.addEventListener("progress",function(e){var r=0,a=e.loaded||e.position,n=e.total;e.lengthComputable&&(r=Math.ceil(a/n*100)),t.uploadProgress(e,a,n,r)},!1),r}),s.data=null;var c=s.beforeSend;return s.beforeSend=function(e,r){r.data=t.formData?t.formData:n,c&&c.call(this,e,r)},e.ajax(s)}function s(r){function n(e){var t=null;try{e.contentWindow&&(t=e.contentWindow.document)}catch(r){a("cannot get iframe.contentWindow document: "+r)}if(t)return t;try{t=e.contentDocument?e.contentDocument:e.document}catch(r){a("cannot get iframe.contentDocument: "+r),t=e.document}return t}function o(){function t(){try{var e=n(g).readyState;a("state = "+e),e&&"uninitialized"==e.toLowerCase()&&setTimeout(t,50)}catch(r){a("Server abort: ",r," (",r.name,")"),s(k),j&&clearTimeout(j),j=void 0}}var r=f.attr2("target"),i=f.attr2("action"),o="multipart/form-data",c=f.attr("enctype")||f.attr("encoding")||o;w.setAttribute("target",p),(!u||/post/i.test(u))&&w.setAttribute("method","POST"),i!=m.url&&w.setAttribute("action",m.url),m.skipEncodingOverride||u&&!/post/i.test(u)||f.attr({encoding:"multipart/form-data",enctype:"multipart/form-data"}),m.timeout&&(j=setTimeout(function(){T=!0,s(D)},m.timeout));var l=[];try{if(m.extraData)for(var d in m.extraData)m.extraData.hasOwnProperty(d)&&l.push(e.isPlainObject(m.extraData[d])&&m.extraData[d].hasOwnProperty("name")&&m.extraData[d].hasOwnProperty("value")?e('<input type="hidden" name="'+m.extraData[d].name+'">').val(m.extraData[d].value).appendTo(w)[0]:e('<input type="hidden" name="'+d+'">').val(m.extraData[d]).appendTo(w)[0]);m.iframeTarget||v.appendTo("body"),g.attachEvent?g.attachEvent("onload",s):g.addEventListener("load",s,!1),setTimeout(t,15);try{w.submit()}catch(h){var x=document.createElement("form").submit;x.apply(w)}}finally{w.setAttribute("action",i),w.setAttribute("enctype",c),r?w.setAttribute("target",r):f.removeAttr("target"),e(l).remove()}}function s(t){if(!x.aborted&&!F){if(M=n(g),M||(a("cannot access response document"),t=k),t===D&&x)return x.abort("timeout"),void S.reject(x,"timeout");if(t==k&&x)return x.abort("server abort"),void S.reject(x,"error","server abort");if(M&&M.location.href!=m.iframeSrc||T){g.detachEvent?g.detachEvent("onload",s):g.removeEventListener("load",s,!1);var r,i="success";try{if(T)throw"timeout";var o="xml"==m.dataType||M.XMLDocument||e.isXMLDoc(M);if(a("isXml="+o),!o&&window.opera&&(null===M.body||!M.body.innerHTML)&&--O)return a("requeing onLoad callback, DOM not available"),void setTimeout(s,250);var u=M.body?M.body:M.documentElement;x.responseText=u?u.innerHTML:null,x.responseXML=M.XMLDocument?M.XMLDocument:M,o&&(m.dataType="xml"),x.getResponseHeader=function(e){var t={"content-type":m.dataType};return t[e.toLowerCase()]},u&&(x.status=Number(u.getAttribute("status"))||x.status,x.statusText=u.getAttribute("statusText")||x.statusText);var c=(m.dataType||"").toLowerCase(),l=/(json|script|text)/.test(c);if(l||m.textarea){var f=M.getElementsByTagName("textarea")[0];if(f)x.responseText=f.value,x.status=Number(f.getAttribute("status"))||x.status,x.statusText=f.getAttribute("statusText")||x.statusText;else if(l){var p=M.getElementsByTagName("pre")[0],h=M.getElementsByTagName("body")[0];p?x.responseText=p.textContent?p.textContent:p.innerText:h&&(x.responseText=h.textContent?h.textContent:h.innerText)}}else"xml"==c&&!x.responseXML&&x.responseText&&(x.responseXML=X(x.responseText));try{E=_(x,c,m)}catch(y){i="parsererror",x.error=r=y||i}}catch(y){a("error caught: ",y),i="error",x.error=r=y||i}x.aborted&&(a("upload aborted"),i=null),x.status&&(i=x.status>=200&&x.status<300||304===x.status?"success":"error"),"success"===i?(m.success&&m.success.call(m.context,E,"success",x),S.resolve(x.responseText,"success",x),d&&e.event.trigger("ajaxSuccess",[x,m])):i&&(void 0===r&&(r=x.statusText),m.error&&m.error.call(m.context,x,i,r),S.reject(x,"error",r),d&&e.event.trigger("ajaxError",[x,m,r])),d&&e.event.trigger("ajaxComplete",[x,m]),d&&!--e.active&&e.event.trigger("ajaxStop"),m.complete&&m.complete.call(m.context,x,i),F=!0,m.timeout&&clearTimeout(j),setTimeout(function(){m.iframeTarget?v.attr("src",m.iframeSrc):v.remove(),x.responseXML=null},100)}}}var c,l,m,d,p,v,g,x,y,b,T,j,w=f[0],S=e.Deferred();if(S.abort=function(e){x.abort(e)},r)for(l=0;l<h.length;l++)c=e(h[l]),i?c.prop("disabled",!1):c.removeAttr("disabled");if(m=e.extend(!0,{},e.ajaxSettings,t),m.context=m.context||m,p="jqFormIO"+(new Date).getTime(),m.iframeTarget?(v=e(m.iframeTarget),b=v.attr2("name"),b?p=b:v.attr2("name",p)):(v=e('<iframe name="'+p+'" src="'+m.iframeSrc+'" />'),v.css({position:"absolute",top:"-1000px",left:"-1000px"})),g=v[0],x={aborted:0,responseText:null,responseXML:null,status:0,statusText:"n/a",getAllResponseHeaders:function(){},getResponseHeader:function(){},setRequestHeader:function(){},abort:function(t){var r="timeout"===t?"timeout":"aborted";a("aborting upload... "+r),this.aborted=1;try{g.contentWindow.document.execCommand&&g.contentWindow.document.execCommand("Stop")}catch(n){}v.attr("src",m.iframeSrc),x.error=r,m.error&&m.error.call(m.context,x,r,t),d&&e.event.trigger("ajaxError",[x,m,r]),m.complete&&m.complete.call(m.context,x,r)}},d=m.global,d&&0===e.active++&&e.event.trigger("ajaxStart"),d&&e.event.trigger("ajaxSend",[x,m]),m.beforeSend&&m.beforeSend.call(m.context,x,m)===!1)return m.global&&e.active--,S.reject(),S;if(x.aborted)return S.reject(),S;y=w.clk,y&&(b=y.name,b&&!y.disabled&&(m.extraData=m.extraData||{},m.extraData[b]=y.value,"image"==y.type&&(m.extraData[b+".x"]=w.clk_x,m.extraData[b+".y"]=w.clk_y)));var D=1,k=2,A=e("meta[name=csrf-token]").attr("content"),L=e("meta[name=csrf-param]").attr("content");L&&A&&(m.extraData=m.extraData||{},m.extraData[L]=A),m.forceSync?o():setTimeout(o,10);var E,M,F,O=50,X=e.parseXML||function(e,t){return window.ActiveXObject?(t=new ActiveXObject("Microsoft.XMLDOM"),t.async="false",t.loadXML(e)):t=(new DOMParser).parseFromString(e,"text/xml"),t&&t.documentElement&&"parsererror"!=t.documentElement.nodeName?t:null},C=e.parseJSON||function(e){return window.eval("("+e+")")},_=function(t,r,a){var n=t.getResponseHeader("content-type")||"",i="xml"===r||!r&&n.indexOf("xml")>=0,o=i?t.responseXML:t.responseText;return i&&"parsererror"===o.documentElement.nodeName&&e.error&&e.error("parsererror"),a&&a.dataFilter&&(o=a.dataFilter(o,r)),"string"==typeof o&&("json"===r||!r&&n.indexOf("json")>=0?o=C(o):("script"===r||!r&&n.indexOf("javascript")>=0)&&e.globalEval(o)),o};return S}if(!this.length)return a("ajaxSubmit: skipping submit process - no element selected"),this;var u,c,l,f=this;"function"==typeof t?t={success:t}:void 0===t&&(t={}),u=t.type||this.attr2("method"),c=t.url||this.attr2("action"),l="string"==typeof c?e.trim(c):"",l=l||window.location.href||"",l&&(l=(l.match(/^([^#]+)/)||[])[1]),t=e.extend(!0,{url:l,success:e.ajaxSettings.success,type:u||e.ajaxSettings.type,iframeSrc:/^https/i.test(window.location.href||"")?"javascript:false":"about:blank"},t);var m={};if(this.trigger("form-pre-serialize",[this,t,m]),m.veto)return a("ajaxSubmit: submit vetoed via form-pre-serialize trigger"),this;if(t.beforeSerialize&&t.beforeSerialize(this,t)===!1)return a("ajaxSubmit: submit aborted via beforeSerialize callback"),this;var d=t.traditional;void 0===d&&(d=e.ajaxSettings.traditional);var p,h=[],v=this.formToArray(t.semantic,h);if(t.data&&(t.extraData=t.data,p=e.param(t.data,d)),t.beforeSubmit&&t.beforeSubmit(v,this,t)===!1)return a("ajaxSubmit: submit aborted via beforeSubmit callback"),this;if(this.trigger("form-submit-validate",[v,this,t,m]),m.veto)return a("ajaxSubmit: submit vetoed via form-submit-validate trigger"),this;var g=e.param(v,d);p&&(g=g?g+"&"+p:p),"GET"==t.type.toUpperCase()?(t.url+=(t.url.indexOf("?")>=0?"&":"?")+g,t.data=null):t.data=g;var x=[];if(t.resetForm&&x.push(function(){f.resetForm()}),t.clearForm&&x.push(function(){f.clearForm(t.includeHidden)}),!t.dataType&&t.target){var y=t.success||function(){};x.push(function(r){var a=t.replaceTarget?"replaceWith":"html";e(t.target)[a](r).each(y,arguments)})}else t.success&&x.push(t.success);if(t.success=function(e,r,a){for(var n=t.context||this,i=0,o=x.length;o>i;i++)x[i].apply(n,[e,r,a||f,f])},t.error){var b=t.error;t.error=function(e,r,a){var n=t.context||this;b.apply(n,[e,r,a,f])}}if(t.complete){var T=t.complete;t.complete=function(e,r){var a=t.context||this;T.apply(a,[e,r,f])}}var j=e("input[type=file]:enabled",this).filter(function(){return""!==e(this).val()}),w=j.length>0,S="multipart/form-data",D=f.attr("enctype")==S||f.attr("encoding")==S,k=n.fileapi&&n.formdata;a("fileAPI :"+k);var A,L=(w||D)&&!k;t.iframe!==!1&&(t.iframe||L)?t.closeKeepAlive?e.get(t.closeKeepAlive,function(){A=s(v)}):A=s(v):A=(w||D)&&k?o(v):e.ajax(t),f.removeData("jqxhr").data("jqxhr",A);for(var E=0;E<h.length;E++)h[E]=null;return this.trigger("form-submit-notify",[this,t]),this},e.fn.ajaxForm=function(n){if(n=n||{},n.delegation=n.delegation&&e.isFunction(e.fn.on),!n.delegation&&0===this.length){var i={s:this.selector,c:this.context};return!e.isReady&&i.s?(a("DOM not ready, queuing ajaxForm"),e(function(){e(i.s,i.c).ajaxForm(n)}),this):(a("terminating; zero elements found by selector"+(e.isReady?"":" (DOM not ready)")),this)}return n.delegation?(e(document).off("submit.form-plugin",this.selector,t).off("click.form-plugin",this.selector,r).on("submit.form-plugin",this.selector,n,t).on("click.form-plugin",this.selector,n,r),this):this.ajaxFormUnbind().bind("submit.form-plugin",n,t).bind("click.form-plugin",n,r)},e.fn.ajaxFormUnbind=function(){return this.unbind("submit.form-plugin click.form-plugin")},e.fn.formToArray=function(t,r){var a=[];if(0===this.length)return a;var i,o=this[0],s=this.attr("id"),u=t?o.getElementsByTagName("*"):o.elements;if(u&&!/MSIE [678]/.test(navigator.userAgent)&&(u=e(u).get()),s&&(i=e(':input[form="'+s+'"]').get(),i.length&&(u=(u||[]).concat(i))),!u||!u.length)return a;var c,l,f,m,d,p,h;for(c=0,p=u.length;p>c;c++)if(d=u[c],f=d.name,f&&!d.disabled)if(t&&o.clk&&"image"==d.type)o.clk==d&&(a.push({name:f,value:e(d).val(),type:d.type}),a.push({name:f+".x",value:o.clk_x},{name:f+".y",value:o.clk_y}));else if(m=e.fieldValue(d,!0),m&&m.constructor==Array)for(r&&r.push(d),l=0,h=m.length;h>l;l++)a.push({name:f,value:m[l]});else if(n.fileapi&&"file"==d.type){r&&r.push(d);var v=d.files;if(v.length)for(l=0;l<v.length;l++)a.push({name:f,value:v[l],type:d.type});else a.push({name:f,value:"",type:d.type})}else null!==m&&"undefined"!=typeof m&&(r&&r.push(d),a.push({name:f,value:m,type:d.type,required:d.required}));if(!t&&o.clk){var g=e(o.clk),x=g[0];f=x.name,f&&!x.disabled&&"image"==x.type&&(a.push({name:f,value:g.val()}),a.push({name:f+".x",value:o.clk_x},{name:f+".y",value:o.clk_y}))}return a},e.fn.formSerialize=function(t){return e.param(this.formToArray(t))},e.fn.fieldSerialize=function(t){var r=[];return this.each(function(){var a=this.name;if(a){var n=e.fieldValue(this,t);if(n&&n.constructor==Array)for(var i=0,o=n.length;o>i;i++)r.push({name:a,value:n[i]});else null!==n&&"undefined"!=typeof n&&r.push({name:this.name,value:n})}}),e.param(r)},e.fn.fieldValue=function(t){for(var r=[],a=0,n=this.length;n>a;a++){var i=this[a],o=e.fieldValue(i,t);null===o||"undefined"==typeof o||o.constructor==Array&&!o.length||(o.constructor==Array?e.merge(r,o):r.push(o))}return r},e.fieldValue=function(t,r){var a=t.name,n=t.type,i=t.tagName.toLowerCase();if(void 0===r&&(r=!0),r&&(!a||t.disabled||"reset"==n||"button"==n||("checkbox"==n||"radio"==n)&&!t.checked||("submit"==n||"image"==n)&&t.form&&t.form.clk!=t||"select"==i&&-1==t.selectedIndex))return null;if("select"==i){var o=t.selectedIndex;if(0>o)return null;for(var s=[],u=t.options,c="select-one"==n,l=c?o+1:u.length,f=c?o:0;l>f;f++){var m=u[f];if(m.selected){var d=m.value;if(d||(d=m.attributes&&m.attributes.value&&!m.attributes.value.specified?m.text:m.value),c)return d;s.push(d)}}return s}return e(t).val()},e.fn.clearForm=function(t){return this.each(function(){e("input,select,textarea",this).clearFields(t)})},e.fn.clearFields=e.fn.clearInputs=function(t){var r=/^(?:color|date|datetime|email|month|number|password|range|search|tel|text|time|url|week)$/i;return this.each(function(){var a=this.type,n=this.tagName.toLowerCase();r.test(a)||"textarea"==n?this.value="":"checkbox"==a||"radio"==a?this.checked=!1:"select"==n?this.selectedIndex=-1:"file"==a?/MSIE/.test(navigator.userAgent)?e(this).replaceWith(e(this).clone(!0)):e(this).val(""):t&&(t===!0&&/hidden/.test(a)||"string"==typeof t&&e(this).is(t))&&(this.value="")})},e.fn.resetForm=function(){return this.each(function(){("function"==typeof this.reset||"object"==typeof this.reset&&!this.reset.nodeType)&&this.reset()})},e.fn.enable=function(e){return void 0===e&&(e=!0),this.each(function(){this.disabled=!e})},e.fn.selected=function(t){return void 0===t&&(t=!0),this.each(function(){var r=this.type;if("checkbox"==r||"radio"==r)this.checked=t;else if("option"==this.tagName.toLowerCase()){var a=e(this).parent("select");t&&a[0]&&"select-one"==a[0].type&&a.find("option").selected(!1),this.selected=t}})},e.fn.ajaxSubmit.debug=!1});
/*jqueryvalidate*/
!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):a(jQuery)}(function(a){a.extend(a.fn,{validate:function(b){if(!this.length)return void(b&&b.debug&&window.console&&console.warn("Nothing selected, can't validate, returning nothing."));var c=a.data(this[0],"validator");return c?c:(this.attr("novalidate","novalidate"),c=new a.validator(b,this[0]),a.data(this[0],"validator",c),c.settings.onsubmit&&(this.on("click.validate",":submit",function(b){c.settings.submitHandler&&(c.submitButton=b.target),a(this).hasClass("cancel")&&(c.cancelSubmit=!0),void 0!==a(this).attr("formnovalidate")&&(c.cancelSubmit=!0)}),this.on("submit.validate",function(b){function d(){var d,e;return c.settings.submitHandler?(c.submitButton&&(d=a("<input type='hidden'/>").attr("name",c.submitButton.name).val(a(c.submitButton).val()).appendTo(c.currentForm)),e=c.settings.submitHandler.call(c,c.currentForm,b),c.submitButton&&d.remove(),void 0!==e?e:!1):!0}return c.settings.debug&&b.preventDefault(),c.cancelSubmit?(c.cancelSubmit=!1,d()):c.form()?c.pendingRequest?(c.formSubmitted=!0,!1):d():(c.focusInvalid(),!1)})),c)},valid:function(){var b,c,d;return a(this[0]).is("form")?b=this.validate().form():(d=[],b=!0,c=a(this[0].form).validate(),this.each(function(){b=c.element(this)&&b,d=d.concat(c.errorList)}),c.errorList=d),b},rules:function(b,c){var d,e,f,g,h,i,j=this[0];if(b)switch(d=a.data(j.form,"validator").settings,e=d.rules,f=a.validator.staticRules(j),b){case"add":a.extend(f,a.validator.normalizeRule(c)),delete f.messages,e[j.name]=f,c.messages&&(d.messages[j.name]=a.extend(d.messages[j.name],c.messages));break;case"remove":return c?(i={},a.each(c.split(/\s/),function(b,c){i[c]=f[c],delete f[c],"required"===c&&a(j).removeAttr("aria-required")}),i):(delete e[j.name],f)}return g=a.validator.normalizeRules(a.extend({},a.validator.classRules(j),a.validator.attributeRules(j),a.validator.dataRules(j),a.validator.staticRules(j)),j),g.required&&(h=g.required,delete g.required,g=a.extend({required:h},g),a(j).attr("aria-required","true")),g.remote&&(h=g.remote,delete g.remote,g=a.extend(g,{remote:h})),g}}),a.extend(a.expr[":"],{blank:function(b){return!a.trim(""+a(b).val())},filled:function(b){return!!a.trim(""+a(b).val())},unchecked:function(b){return!a(b).prop("checked")}}),a.validator=function(b,c){this.settings=a.extend(!0,{},a.validator.defaults,b),this.currentForm=c,this.init()},a.validator.format=function(b,c){return 1===arguments.length?function(){var c=a.makeArray(arguments);return c.unshift(b),a.validator.format.apply(this,c)}:(arguments.length>2&&c.constructor!==Array&&(c=a.makeArray(arguments).slice(1)),c.constructor!==Array&&(c=[c]),a.each(c,function(a,c){b=b.replace(new RegExp("\\{"+a+"\\}","g"),function(){return c})}),b)},a.extend(a.validator,{defaults:{messages:{},groups:{},rules:{},errorClass:"error",validClass:"valid",errorElement:"label",focusCleanup:!1,focusInvalid:!0,errorContainer:a([]),errorLabelContainer:a([]),onsubmit:!0,ignore:":hidden",ignoreTitle:!1,onfocusin:function(a){this.lastActive=a,this.settings.focusCleanup&&(this.settings.unhighlight&&this.settings.unhighlight.call(this,a,this.settings.errorClass,this.settings.validClass),this.hideThese(this.errorsFor(a)))},onfocusout:function(a){this.checkable(a)||!(a.name in this.submitted)&&this.optional(a)||this.element(a)},onkeyup:function(b,c){var d=[16,17,18,20,35,36,37,38,39,40,45,144,225];9===c.which&&""===this.elementValue(b)||-1!==a.inArray(c.keyCode,d)||(b.name in this.submitted||b===this.lastElement)&&this.element(b)},onclick:function(a){a.name in this.submitted?this.element(a):a.parentNode.name in this.submitted&&this.element(a.parentNode)},highlight:function(b,c,d){"radio"===b.type?this.findByName(b.name).addClass(c).removeClass(d):a(b).addClass(c).removeClass(d)},unhighlight:function(b,c,d){"radio"===b.type?this.findByName(b.name).removeClass(c).addClass(d):a(b).removeClass(c).addClass(d)}},setDefaults:function(b){a.extend(a.validator.defaults,b)},messages:{required:"This field is required.",remote:"Please fix this field.",email:"Please enter a valid email address.",url:"Please enter a valid URL.",date:"Please enter a valid date.",dateISO:"Please enter a valid date ( ISO ).",number:"Please enter a valid number.",digits:"Please enter only digits.",creditcard:"Please enter a valid credit card number.",equalTo:"Please enter the same value again.",maxlength:a.validator.format("Please enter no more than {0} characters."),minlength:a.validator.format("Please enter at least {0} characters."),rangelength:a.validator.format("Please enter a value between {0} and {1} characters long."),range:a.validator.format("Please enter a value between {0} and {1}."),max:a.validator.format("Please enter a value less than or equal to {0}."),min:a.validator.format("Please enter a value greater than or equal to {0}.")},autoCreateRanges:!1,prototype:{init:function(){function b(b){var c=a.data(this.form,"validator"),d="on"+b.type.replace(/^validate/,""),e=c.settings;e[d]&&!a(this).is(e.ignore)&&e[d].call(c,this,b)}this.labelContainer=a(this.settings.errorLabelContainer),this.errorContext=this.labelContainer.length&&this.labelContainer||a(this.currentForm),this.containers=a(this.settings.errorContainer).add(this.settings.errorLabelContainer),this.submitted={},this.valueCache={},this.pendingRequest=0,this.pending={},this.invalid={},this.reset();var c,d=this.groups={};a.each(this.settings.groups,function(b,c){"string"==typeof c&&(c=c.split(/\s/)),a.each(c,function(a,c){d[c]=b})}),c=this.settings.rules,a.each(c,function(b,d){c[b]=a.validator.normalizeRule(d)}),a(this.currentForm).on("focusin.validate focusout.validate keyup.validate",":text, [type='password'], [type='file'], select, textarea, [type='number'], [type='search'], [type='tel'], [type='url'], [type='email'], [type='datetime'], [type='date'], [type='month'], [type='week'], [type='time'], [type='datetime-local'], [type='range'], [type='color'], [type='radio'], [type='checkbox']",b).on("click.validate","select, option, [type='radio'], [type='checkbox']",b),this.settings.invalidHandler&&a(this.currentForm).on("invalid-form.validate",this.settings.invalidHandler),a(this.currentForm).find("[required], [data-rule-required], .required").attr("aria-required","true")},form:function(){return this.checkForm(),a.extend(this.submitted,this.errorMap),this.invalid=a.extend({},this.errorMap),this.valid()||a(this.currentForm).triggerHandler("invalid-form",[this]),this.showErrors(),this.valid()},checkForm:function(){this.prepareForm();for(var a=0,b=this.currentElements=this.elements();b[a];a++)this.check(b[a]);return this.valid()},element:function(b){var c=this.clean(b),d=this.validationTargetFor(c),e=!0;return this.lastElement=d,void 0===d?delete this.invalid[c.name]:(this.prepareElement(d),this.currentElements=a(d),e=this.check(d)!==!1,e?delete this.invalid[d.name]:this.invalid[d.name]=!0),a(b).attr("aria-invalid",!e),this.numberOfInvalids()||(this.toHide=this.toHide.add(this.containers)),this.showErrors(),e},showErrors:function(b){if(b){a.extend(this.errorMap,b),this.errorList=[];for(var c in b)this.errorList.push({message:b[c],element:this.findByName(c)[0]});this.successList=a.grep(this.successList,function(a){return!(a.name in b)})}this.settings.showErrors?this.settings.showErrors.call(this,this.errorMap,this.errorList):this.defaultShowErrors()},resetForm:function(){a.fn.resetForm&&a(this.currentForm).resetForm(),this.submitted={},this.lastElement=null,this.prepareForm(),this.hideErrors();var b,c=this.elements().removeData("previousValue").removeAttr("aria-invalid");if(this.settings.unhighlight)for(b=0;c[b];b++)this.settings.unhighlight.call(this,c[b],this.settings.errorClass,"");else c.removeClass(this.settings.errorClass)},numberOfInvalids:function(){return this.objectLength(this.invalid)},objectLength:function(a){var b,c=0;for(b in a)c++;return c},hideErrors:function(){this.hideThese(this.toHide)},hideThese:function(a){a.not(this.containers).text(""),this.addWrapper(a).hide()},valid:function(){return 0===this.size()},size:function(){return this.errorList.length},focusInvalid:function(){if(this.settings.focusInvalid)try{a(this.findLastActive()||this.errorList.length&&this.errorList[0].element||[]).filter(":visible").focus().trigger("focusin")}catch(b){}},findLastActive:function(){var b=this.lastActive;return b&&1===a.grep(this.errorList,function(a){return a.element.name===b.name}).length&&b},elements:function(){var b=this,c={};return a(this.currentForm).find("input, select, textarea").not(":submit, :reset, :image, :disabled").not(this.settings.ignore).filter(function(){return!this.name&&b.settings.debug&&window.console&&console.error("%o has no name assigned",this),this.name in c||!b.objectLength(a(this).rules())?!1:(c[this.name]=!0,!0)})},clean:function(b){return a(b)[0]},errors:function(){var b=this.settings.errorClass.split(" ").join(".");return a(this.settings.errorElement+"."+b,this.errorContext)},reset:function(){this.successList=[],this.errorList=[],this.errorMap={},this.toShow=a([]),this.toHide=a([]),this.currentElements=a([])},prepareForm:function(){this.reset(),this.toHide=this.errors().add(this.containers)},prepareElement:function(a){this.reset(),this.toHide=this.errorsFor(a)},elementValue:function(b){var c,d=a(b),e=b.type;return"radio"===e||"checkbox"===e?this.findByName(b.name).filter(":checked").val():"number"===e&&"undefined"!=typeof b.validity?b.validity.badInput?!1:d.val():(c=d.val(),"string"==typeof c?c.replace(/\r/g,""):c)},check:function(b){b=this.validationTargetFor(this.clean(b));var c,d,e,f=a(b).rules(),g=a.map(f,function(a,b){return b}).length,h=!1,i=this.elementValue(b);for(d in f){e={method:d,parameters:f[d]};try{if(c=a.validator.methods[d].call(this,i,b,e.parameters),"dependency-mismatch"===c&&1===g){h=!0;continue}if(h=!1,"pending"===c)return void(this.toHide=this.toHide.not(this.errorsFor(b)));if(!c)return this.formatAndAdd(b,e),!1}catch(j){throw this.settings.debug&&window.console&&console.log("Exception occurred when checking element "+b.id+", check the '"+e.method+"' method.",j),j instanceof TypeError&&(j.message+=".  Exception occurred when checking element "+b.id+", check the '"+e.method+"' method."),j}}if(!h)return this.objectLength(f)&&this.successList.push(b),!0},customDataMessage:function(b,c){return a(b).data("msg"+c.charAt(0).toUpperCase()+c.substring(1).toLowerCase())||a(b).data("msg")},customMessage:function(a,b){var c=this.settings.messages[a];return c&&(c.constructor===String?c:c[b])},findDefined:function(){for(var a=0;a<arguments.length;a++)if(void 0!==arguments[a])return arguments[a];return void 0},defaultMessage:function(b,c){return this.findDefined(this.customMessage(b.name,c),this.customDataMessage(b,c),!this.settings.ignoreTitle&&b.title||void 0,a.validator.messages[c],"<strong>Warning: No message defined for "+b.name+"</strong>")},formatAndAdd:function(b,c){var d=this.defaultMessage(b,c.method),e=/\$?\{(\d+)\}/g;"function"==typeof d?d=d.call(this,c.parameters,b):e.test(d)&&(d=a.validator.format(d.replace(e,"{$1}"),c.parameters)),this.errorList.push({message:d,element:b,method:c.method}),this.errorMap[b.name]=d,this.submitted[b.name]=d},addWrapper:function(a){return this.settings.wrapper&&(a=a.add(a.parent(this.settings.wrapper))),a},defaultShowErrors:function(){var a,b,c;for(a=0;this.errorList[a];a++)c=this.errorList[a],this.settings.highlight&&this.settings.highlight.call(this,c.element,this.settings.errorClass,this.settings.validClass),this.showLabel(c.element,c.message);if(this.errorList.length&&(this.toShow=this.toShow.add(this.containers)),this.settings.success)for(a=0;this.successList[a];a++)this.showLabel(this.successList[a]);if(this.settings.unhighlight)for(a=0,b=this.validElements();b[a];a++)this.settings.unhighlight.call(this,b[a],this.settings.errorClass,this.settings.validClass);this.toHide=this.toHide.not(this.toShow),this.hideErrors(),this.addWrapper(this.toShow).show()},validElements:function(){return this.currentElements.not(this.invalidElements())},invalidElements:function(){return a(this.errorList).map(function(){return this.element})},showLabel:function(b,c){var d,e,f,g=this.errorsFor(b),h=this.idOrName(b),i=a(b).attr("aria-describedby");g.length?(g.removeClass(this.settings.validClass).addClass(this.settings.errorClass),g.html(c)):(g=a("<"+this.settings.errorElement+">").attr("id",h+"-error").addClass(this.settings.errorClass).html(c||""),d=g,this.settings.wrapper&&(d=g.hide().show().wrap("<"+this.settings.wrapper+"/>").parent()),this.labelContainer.length?this.labelContainer.append(d):this.settings.errorPlacement?this.settings.errorPlacement(d,a(b)):d.insertAfter(b),g.is("label")?g.attr("for",h):0===g.parents("label[for='"+h+"']").length&&(f=g.attr("id").replace(/(:|\.|\[|\]|\$)/g,"\\$1"),i?i.match(new RegExp("\\b"+f+"\\b"))||(i+=" "+f):i=f,a(b).attr("aria-describedby",i),e=this.groups[b.name],e&&a.each(this.groups,function(b,c){c===e&&a("[name='"+b+"']",this.currentForm).attr("aria-describedby",g.attr("id"))}))),!c&&this.settings.success&&(g.text(""),"string"==typeof this.settings.success?g.addClass(this.settings.success):this.settings.success(g,b)),this.toShow=this.toShow.add(g)},errorsFor:function(b){var c=this.idOrName(b),d=a(b).attr("aria-describedby"),e="label[for='"+c+"'], label[for='"+c+"'] *";return d&&(e=e+", #"+d.replace(/\s+/g,", #")),this.errors().filter(e)},idOrName:function(a){return this.groups[a.name]||(this.checkable(a)?a.name:a.id||a.name)},validationTargetFor:function(b){return this.checkable(b)&&(b=this.findByName(b.name)),a(b).not(this.settings.ignore)[0]},checkable:function(a){return/radio|checkbox/i.test(a.type)},findByName:function(b){return a(this.currentForm).find("[name='"+b+"']")},getLength:function(b,c){switch(c.nodeName.toLowerCase()){case"select":return a("option:selected",c).length;case"input":if(this.checkable(c))return this.findByName(c.name).filter(":checked").length}return b.length},depend:function(a,b){return this.dependTypes[typeof a]?this.dependTypes[typeof a](a,b):!0},dependTypes:{"boolean":function(a){return a},string:function(b,c){return!!a(b,c.form).length},"function":function(a,b){return a(b)}},optional:function(b){var c=this.elementValue(b);return!a.validator.methods.required.call(this,c,b)&&"dependency-mismatch"},startRequest:function(a){this.pending[a.name]||(this.pendingRequest++,this.pending[a.name]=!0)},stopRequest:function(b,c){this.pendingRequest--,this.pendingRequest<0&&(this.pendingRequest=0),delete this.pending[b.name],c&&0===this.pendingRequest&&this.formSubmitted&&this.form()?(a(this.currentForm).submit(),this.formSubmitted=!1):!c&&0===this.pendingRequest&&this.formSubmitted&&(a(this.currentForm).triggerHandler("invalid-form",[this]),this.formSubmitted=!1)},previousValue:function(b){return a.data(b,"previousValue")||a.data(b,"previousValue",{old:null,valid:!0,message:this.defaultMessage(b,"remote")})},destroy:function(){this.resetForm(),a(this.currentForm).off(".validate").removeData("validator")}},classRuleSettings:{required:{required:!0},email:{email:!0},url:{url:!0},date:{date:!0},dateISO:{dateISO:!0},number:{number:!0},digits:{digits:!0},creditcard:{creditcard:!0}},addClassRules:function(b,c){b.constructor===String?this.classRuleSettings[b]=c:a.extend(this.classRuleSettings,b)},classRules:function(b){var c={},d=a(b).attr("class");return d&&a.each(d.split(" "),function(){this in a.validator.classRuleSettings&&a.extend(c,a.validator.classRuleSettings[this])}),c},normalizeAttributeRule:function(a,b,c,d){/min|max/.test(c)&&(null===b||/number|range|text/.test(b))&&(d=Number(d),isNaN(d)&&(d=void 0)),d||0===d?a[c]=d:b===c&&"range"!==b&&(a[c]=!0)},attributeRules:function(b){var c,d,e={},f=a(b),g=b.getAttribute("type");for(c in a.validator.methods)"required"===c?(d=b.getAttribute(c),""===d&&(d=!0),d=!!d):d=f.attr(c),this.normalizeAttributeRule(e,g,c,d);return e.maxlength&&/-1|2147483647|524288/.test(e.maxlength)&&delete e.maxlength,e},dataRules:function(b){var c,d,e={},f=a(b),g=b.getAttribute("type");for(c in a.validator.methods)d=f.data("rule"+c.charAt(0).toUpperCase()+c.substring(1).toLowerCase()),this.normalizeAttributeRule(e,g,c,d);return e},staticRules:function(b){var c={},d=a.data(b.form,"validator");return d.settings.rules&&(c=a.validator.normalizeRule(d.settings.rules[b.name])||{}),c},normalizeRules:function(b,c){return a.each(b,function(d,e){if(e===!1)return void delete b[d];if(e.param||e.depends){var f=!0;switch(typeof e.depends){case"string":f=!!a(e.depends,c.form).length;break;case"function":f=e.depends.call(c,c)}f?b[d]=void 0!==e.param?e.param:!0:delete b[d]}}),a.each(b,function(d,e){b[d]=a.isFunction(e)?e(c):e}),a.each(["minlength","maxlength"],function(){b[this]&&(b[this]=Number(b[this]))}),a.each(["rangelength","range"],function(){var c;b[this]&&(a.isArray(b[this])?b[this]=[Number(b[this][0]),Number(b[this][1])]:"string"==typeof b[this]&&(c=b[this].replace(/[\[\]]/g,"").split(/[\s,]+/),b[this]=[Number(c[0]),Number(c[1])]))}),a.validator.autoCreateRanges&&(null!=b.min&&null!=b.max&&(b.range=[b.min,b.max],delete b.min,delete b.max),null!=b.minlength&&null!=b.maxlength&&(b.rangelength=[b.minlength,b.maxlength],delete b.minlength,delete b.maxlength)),b},normalizeRule:function(b){if("string"==typeof b){var c={};a.each(b.split(/\s/),function(){c[this]=!0}),b=c}return b},addMethod:function(b,c,d){a.validator.methods[b]=c,a.validator.messages[b]=void 0!==d?d:a.validator.messages[b],c.length<3&&a.validator.addClassRules(b,a.validator.normalizeRule(b))},methods:{required:function(b,c,d){if(!this.depend(d,c))return"dependency-mismatch";if("select"===c.nodeName.toLowerCase()){var e=a(c).val();return e&&e.length>0}return this.checkable(c)?this.getLength(b,c)>0:b.length>0},email:function(a,b){return this.optional(b)||/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test(a)},url:function(a,b){return this.optional(b)||/^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(a)},date:function(a,b){return this.optional(b)||!/Invalid|NaN/.test(new Date(a).toString())},dateISO:function(a,b){return this.optional(b)||/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/.test(a)},number:function(a,b){return this.optional(b)||/^(?:-?\d+|-?\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(a)},digits:function(a,b){return this.optional(b)||/^\d+$/.test(a)},creditcard:function(a,b){if(this.optional(b))return"dependency-mismatch";if(/[^0-9 \-]+/.test(a))return!1;var c,d,e=0,f=0,g=!1;if(a=a.replace(/\D/g,""),a.length<13||a.length>19)return!1;for(c=a.length-1;c>=0;c--)d=a.charAt(c),f=parseInt(d,10),g&&(f*=2)>9&&(f-=9),e+=f,g=!g;return e%10===0},minlength:function(b,c,d){var e=a.isArray(b)?b.length:this.getLength(b,c);return this.optional(c)||e>=d},maxlength:function(b,c,d){var e=a.isArray(b)?b.length:this.getLength(b,c);return this.optional(c)||d>=e},rangelength:function(b,c,d){var e=a.isArray(b)?b.length:this.getLength(b,c);return this.optional(c)||e>=d[0]&&e<=d[1]},min:function(a,b,c){return this.optional(b)||a>=c},max:function(a,b,c){return this.optional(b)||c>=a},range:function(a,b,c){return this.optional(b)||a>=c[0]&&a<=c[1]},equalTo:function(b,c,d){var e=a(d);return this.settings.onfocusout&&e.off(".validate-equalTo").on("blur.validate-equalTo",function(){a(c).valid()}),b===e.val()},remote:function(b,c,d){if(this.optional(c))return"dependency-mismatch";var e,f,g=this.previousValue(c);return this.settings.messages[c.name]||(this.settings.messages[c.name]={}),g.originalMessage=this.settings.messages[c.name].remote,this.settings.messages[c.name].remote=g.message,d="string"==typeof d&&{url:d}||d,g.old===b?g.valid:(g.old=b,e=this,this.startRequest(c),f={},f[c.name]=b,a.ajax(a.extend(!0,{mode:"abort",port:"validate"+c.name,dataType:"json",data:f,context:e.currentForm,success:function(d){var f,h,i,j=d===!0||"true"===d;e.settings.messages[c.name].remote=g.originalMessage,j?(i=e.formSubmitted,e.prepareElement(c),e.formSubmitted=i,e.successList.push(c),delete e.invalid[c.name],e.showErrors()):(f={},h=d||e.defaultMessage(c,"remote"),f[c.name]=g.message=a.isFunction(h)?h(b):h,e.invalid[c.name]=!0,e.showErrors(f)),g.valid=j,e.stopRequest(c,j)}},d)),"pending")}}});var b,c={};a.ajaxPrefilter?a.ajaxPrefilter(function(a,b,d){var e=a.port;"abort"===a.mode&&(c[e]&&c[e].abort(),c[e]=d)}):(b=a.ajax,a.ajax=function(d){var e=("mode"in d?d:a.ajaxSettings).mode,f=("port"in d?d:a.ajaxSettings).port;return"abort"===e?(c[f]&&c[f].abort(),c[f]=b.apply(this,arguments),c[f]):b.apply(this,arguments)})});

/**
 * @license
 * lodash 4.3.0 <https://lodash.com/>
 * Copyright 2012-2016 The Dojo Foundation <http://dojofoundation.org/>
 * Based on Underscore.js 1.8.3 <http://underscorejs.org/LICENSE>
 * Copyright 2009-2016 Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
 * Available under MIT license <https://lodash.com/license>
 */
;(function() {

    /** Used as a safe reference for `undefined` in pre-ES5 environments. */
    var undefined;

    /** Used as the semantic version number. */
    var VERSION = '4.3.0';

    /** Used to compose bitmasks for wrapper metadata. */
    var BIND_FLAG = 1,
        BIND_KEY_FLAG = 2,
        CURRY_BOUND_FLAG = 4,
        CURRY_FLAG = 8,
        CURRY_RIGHT_FLAG = 16,
        PARTIAL_FLAG = 32,
        PARTIAL_RIGHT_FLAG = 64,
        ARY_FLAG = 128,
        REARG_FLAG = 256,
        FLIP_FLAG = 512;

    /** Used to compose bitmasks for comparison styles. */
    var UNORDERED_COMPARE_FLAG = 1,
        PARTIAL_COMPARE_FLAG = 2;

    /** Used as default options for `_.truncate`. */
    var DEFAULT_TRUNC_LENGTH = 30,
        DEFAULT_TRUNC_OMISSION = '...';

    /** Used to detect hot functions by number of calls within a span of milliseconds. */
    var HOT_COUNT = 150,
        HOT_SPAN = 16;

    /** Used as the size to enable large array optimizations. */
    var LARGE_ARRAY_SIZE = 200;

    /** Used to indicate the type of lazy iteratees. */
    var LAZY_FILTER_FLAG = 1,
        LAZY_MAP_FLAG = 2,
        LAZY_WHILE_FLAG = 3;

    /** Used as the `TypeError` message for "Functions" methods. */
    var FUNC_ERROR_TEXT = 'Expected a function';

    /** Used to stand-in for `undefined` hash values. */
    var HASH_UNDEFINED = '__lodash_hash_undefined__';

    /** Used as references for various `Number` constants. */
    var INFINITY = 1 / 0,
        MAX_SAFE_INTEGER = 9007199254740991,
        MAX_INTEGER = 1.7976931348623157e+308,
        NAN = 0 / 0;

    /** Used as references for the maximum length and index of an array. */
    var MAX_ARRAY_LENGTH = 4294967295,
        MAX_ARRAY_INDEX = MAX_ARRAY_LENGTH - 1,
        HALF_MAX_ARRAY_LENGTH = MAX_ARRAY_LENGTH >>> 1;

    /** Used as the internal argument placeholder. */
    var PLACEHOLDER = '__lodash_placeholder__';

    /** `Object#toString` result references. */
    var argsTag = '[object Arguments]',
        arrayTag = '[object Array]',
        boolTag = '[object Boolean]',
        dateTag = '[object Date]',
        errorTag = '[object Error]',
        funcTag = '[object Function]',
        genTag = '[object GeneratorFunction]',
        mapTag = '[object Map]',
        numberTag = '[object Number]',
        objectTag = '[object Object]',
        regexpTag = '[object RegExp]',
        setTag = '[object Set]',
        stringTag = '[object String]',
        symbolTag = '[object Symbol]',
        weakMapTag = '[object WeakMap]',
        weakSetTag = '[object WeakSet]';

    var arrayBufferTag = '[object ArrayBuffer]',
        float32Tag = '[object Float32Array]',
        float64Tag = '[object Float64Array]',
        int8Tag = '[object Int8Array]',
        int16Tag = '[object Int16Array]',
        int32Tag = '[object Int32Array]',
        uint8Tag = '[object Uint8Array]',
        uint8ClampedTag = '[object Uint8ClampedArray]',
        uint16Tag = '[object Uint16Array]',
        uint32Tag = '[object Uint32Array]';

    /** Used to match empty string literals in compiled template source. */
    var reEmptyStringLeading = /\b__p \+= '';/g,
        reEmptyStringMiddle = /\b(__p \+=) '' \+/g,
        reEmptyStringTrailing = /(__e\(.*?\)|\b__t\)) \+\n'';/g;

    /** Used to match HTML entities and HTML characters. */
    var reEscapedHtml = /&(?:amp|lt|gt|quot|#39|#96);/g,
        reUnescapedHtml = /[&<>"'`]/g,
        reHasEscapedHtml = RegExp(reEscapedHtml.source),
        reHasUnescapedHtml = RegExp(reUnescapedHtml.source);

    /** Used to match template delimiters. */
    var reEscape = /<%-([\s\S]+?)%>/g,
        reEvaluate = /<%([\s\S]+?)%>/g,
        reInterpolate = /<%=([\s\S]+?)%>/g;

    /** Used to match property names within property paths. */
    var reIsDeepProp = /\.|\[(?:[^[\]]*|(["'])(?:(?!\1)[^\\]|\\.)*?\1)\]/,
        reIsPlainProp = /^\w*$/,
        rePropName = /[^.[\]]+|\[(?:(-?\d+(?:\.\d+)?)|(["'])((?:(?!\2)[^\\]|\\.)*?)\2)\]/g;

    /** Used to match `RegExp` [syntax characters](http://ecma-international.org/ecma-262/6.0/#sec-patterns). */
    var reRegExpChar = /[\\^$.*+?()[\]{}|]/g,
        reHasRegExpChar = RegExp(reRegExpChar.source);

    /** Used to match leading and trailing whitespace. */
    var reTrim = /^\s+|\s+$/g,
        reTrimStart = /^\s+/,
        reTrimEnd = /\s+$/;

    /** Used to match backslashes in property paths. */
    var reEscapeChar = /\\(\\)?/g;

    /** Used to match [ES template delimiters](http://ecma-international.org/ecma-262/6.0/#sec-template-literal-lexical-components). */
    var reEsTemplate = /\$\{([^\\}]*(?:\\.[^\\}]*)*)\}/g;

    /** Used to match `RegExp` flags from their coerced string values. */
    var reFlags = /\w*$/;

    /** Used to detect hexadecimal string values. */
    var reHasHexPrefix = /^0x/i;

    /** Used to detect bad signed hexadecimal string values. */
    var reIsBadHex = /^[-+]0x[0-9a-f]+$/i;

    /** Used to detect binary string values. */
    var reIsBinary = /^0b[01]+$/i;

    /** Used to detect host constructors (Safari > 5). */
    var reIsHostCtor = /^\[object .+?Constructor\]$/;

    /** Used to detect octal string values. */
    var reIsOctal = /^0o[0-7]+$/i;

    /** Used to detect unsigned integer values. */
    var reIsUint = /^(?:0|[1-9]\d*)$/;

    /** Used to match latin-1 supplementary letters (excluding mathematical operators). */
    var reLatin1 = /[\xc0-\xd6\xd8-\xde\xdf-\xf6\xf8-\xff]/g;

    /** Used to ensure capturing order of template delimiters. */
    var reNoMatch = /($^)/;

    /** Used to match unescaped characters in compiled string literals. */
    var reUnescapedString = /['\n\r\u2028\u2029\\]/g;

    /** Used to compose unicode character classes. */
    var rsAstralRange = '\\ud800-\\udfff',
        rsComboMarksRange = '\\u0300-\\u036f\\ufe20-\\ufe23',
        rsComboSymbolsRange = '\\u20d0-\\u20f0',
        rsDingbatRange = '\\u2700-\\u27bf',
        rsLowerRange = 'a-z\\xdf-\\xf6\\xf8-\\xff',
        rsMathOpRange = '\\xac\\xb1\\xd7\\xf7',
        rsNonCharRange = '\\x00-\\x2f\\x3a-\\x40\\x5b-\\x60\\x7b-\\xbf',
        rsQuoteRange = '\\u2018\\u2019\\u201c\\u201d',
        rsSpaceRange = ' \\t\\x0b\\f\\xa0\\ufeff\\n\\r\\u2028\\u2029\\u1680\\u180e\\u2000\\u2001\\u2002\\u2003\\u2004\\u2005\\u2006\\u2007\\u2008\\u2009\\u200a\\u202f\\u205f\\u3000',
        rsUpperRange = 'A-Z\\xc0-\\xd6\\xd8-\\xde',
        rsVarRange = '\\ufe0e\\ufe0f',
        rsBreakRange = rsMathOpRange + rsNonCharRange + rsQuoteRange + rsSpaceRange;

    /** Used to compose unicode capture groups. */
    var rsAstral = '[' + rsAstralRange + ']',
        rsBreak = '[' + rsBreakRange + ']',
        rsCombo = '[' + rsComboMarksRange + rsComboSymbolsRange + ']',
        rsDigits = '\\d+',
        rsDingbat = '[' + rsDingbatRange + ']',
        rsLower = '[' + rsLowerRange + ']',
        rsMisc = '[^' + rsAstralRange + rsBreakRange + rsDigits + rsDingbatRange + rsLowerRange + rsUpperRange + ']',
        rsFitz = '\\ud83c[\\udffb-\\udfff]',
        rsModifier = '(?:' + rsCombo + '|' + rsFitz + ')',
        rsNonAstral = '[^' + rsAstralRange + ']',
        rsRegional = '(?:\\ud83c[\\udde6-\\uddff]){2}',
        rsSurrPair = '[\\ud800-\\udbff][\\udc00-\\udfff]',
        rsUpper = '[' + rsUpperRange + ']',
        rsZWJ = '\\u200d';

    /** Used to compose unicode regexes. */
    var rsLowerMisc = '(?:' + rsLower + '|' + rsMisc + ')',
        rsUpperMisc = '(?:' + rsUpper + '|' + rsMisc + ')',
        reOptMod = rsModifier + '?',
        rsOptVar = '[' + rsVarRange + ']?',
        rsOptJoin = '(?:' + rsZWJ + '(?:' + [rsNonAstral, rsRegional, rsSurrPair].join('|') + ')' + rsOptVar + reOptMod + ')*',
        rsSeq = rsOptVar + reOptMod + rsOptJoin,
        rsEmoji = '(?:' + [rsDingbat, rsRegional, rsSurrPair].join('|') + ')' + rsSeq,
        rsSymbol = '(?:' + [rsNonAstral + rsCombo + '?', rsCombo, rsRegional, rsSurrPair, rsAstral].join('|') + ')';

    /**
     * Used to match [combining diacritical marks](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks) and
     * [combining diacritical marks for symbols](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_for_Symbols).
     */
    var reComboMark = RegExp(rsCombo, 'g');

    /** Used to match [string symbols](https://mathiasbynens.be/notes/javascript-unicode). */
    var reComplexSymbol = RegExp(rsFitz + '(?=' + rsFitz + ')|' + rsSymbol + rsSeq, 'g');

    /** Used to detect strings with [zero-width joiners or code points from the astral planes](http://eev.ee/blog/2015/09/12/dark-corners-of-unicode/). */
    var reHasComplexSymbol = RegExp('[' + rsZWJ + rsAstralRange  + rsComboMarksRange + rsComboSymbolsRange + rsVarRange + ']');

    /** Used to match non-compound words composed of alphanumeric characters. */
    var reBasicWord = /[a-zA-Z0-9]+/g;

    /** Used to match complex or compound words. */
    var reComplexWord = RegExp([
        rsUpper + '?' + rsLower + '+(?=' + [rsBreak, rsUpper, '$'].join('|') + ')',
        rsUpperMisc + '+(?=' + [rsBreak, rsUpper + rsLowerMisc, '$'].join('|') + ')',
        rsUpper + '?' + rsLowerMisc + '+',
        rsUpper + '+',
        rsDigits,
        rsEmoji
    ].join('|'), 'g');

    /** Used to detect strings that need a more robust regexp to match words. */
    var reHasComplexWord = /[a-z][A-Z]|[0-9][a-zA-Z]|[a-zA-Z][0-9]|[^a-zA-Z0-9 ]/;

    /** Used to assign default `context` object properties. */
    var contextProps = [
        'Array', 'Buffer', 'Date', 'Error', 'Float32Array', 'Float64Array',
        'Function', 'Int8Array', 'Int16Array', 'Int32Array', 'Map', 'Math', 'Object',
        'Reflect', 'RegExp', 'Set', 'String', 'Symbol', 'TypeError', 'Uint8Array',
        'Uint8ClampedArray', 'Uint16Array', 'Uint32Array', 'WeakMap', '_',
        'clearTimeout', 'isFinite', 'parseInt', 'setTimeout'
    ];

    /** Used to make template sourceURLs easier to identify. */
    var templateCounter = -1;

    /** Used to identify `toStringTag` values of typed arrays. */
    var typedArrayTags = {};
    typedArrayTags[float32Tag] = typedArrayTags[float64Tag] =
        typedArrayTags[int8Tag] = typedArrayTags[int16Tag] =
            typedArrayTags[int32Tag] = typedArrayTags[uint8Tag] =
                typedArrayTags[uint8ClampedTag] = typedArrayTags[uint16Tag] =
                    typedArrayTags[uint32Tag] = true;
    typedArrayTags[argsTag] = typedArrayTags[arrayTag] =
        typedArrayTags[arrayBufferTag] = typedArrayTags[boolTag] =
            typedArrayTags[dateTag] = typedArrayTags[errorTag] =
                typedArrayTags[funcTag] = typedArrayTags[mapTag] =
                    typedArrayTags[numberTag] = typedArrayTags[objectTag] =
                        typedArrayTags[regexpTag] = typedArrayTags[setTag] =
                            typedArrayTags[stringTag] = typedArrayTags[weakMapTag] = false;

    /** Used to identify `toStringTag` values supported by `_.clone`. */
    var cloneableTags = {};
    cloneableTags[argsTag] = cloneableTags[arrayTag] =
        cloneableTags[arrayBufferTag] = cloneableTags[boolTag] =
            cloneableTags[dateTag] = cloneableTags[float32Tag] =
                cloneableTags[float64Tag] = cloneableTags[int8Tag] =
                    cloneableTags[int16Tag] = cloneableTags[int32Tag] =
                        cloneableTags[mapTag] = cloneableTags[numberTag] =
                            cloneableTags[objectTag] = cloneableTags[regexpTag] =
                                cloneableTags[setTag] = cloneableTags[stringTag] =
                                    cloneableTags[symbolTag] = cloneableTags[uint8Tag] =
                                        cloneableTags[uint8ClampedTag] = cloneableTags[uint16Tag] =
                                            cloneableTags[uint32Tag] = true;
    cloneableTags[errorTag] = cloneableTags[funcTag] =
        cloneableTags[weakMapTag] = false;

    /** Used to map latin-1 supplementary letters to basic latin letters. */
    var deburredLetters = {
        '\xc0': 'A',  '\xc1': 'A', '\xc2': 'A', '\xc3': 'A', '\xc4': 'A', '\xc5': 'A',
        '\xe0': 'a',  '\xe1': 'a', '\xe2': 'a', '\xe3': 'a', '\xe4': 'a', '\xe5': 'a',
        '\xc7': 'C',  '\xe7': 'c',
        '\xd0': 'D',  '\xf0': 'd',
        '\xc8': 'E',  '\xc9': 'E', '\xca': 'E', '\xcb': 'E',
        '\xe8': 'e',  '\xe9': 'e', '\xea': 'e', '\xeb': 'e',
        '\xcC': 'I',  '\xcd': 'I', '\xce': 'I', '\xcf': 'I',
        '\xeC': 'i',  '\xed': 'i', '\xee': 'i', '\xef': 'i',
        '\xd1': 'N',  '\xf1': 'n',
        '\xd2': 'O',  '\xd3': 'O', '\xd4': 'O', '\xd5': 'O', '\xd6': 'O', '\xd8': 'O',
        '\xf2': 'o',  '\xf3': 'o', '\xf4': 'o', '\xf5': 'o', '\xf6': 'o', '\xf8': 'o',
        '\xd9': 'U',  '\xda': 'U', '\xdb': 'U', '\xdc': 'U',
        '\xf9': 'u',  '\xfa': 'u', '\xfb': 'u', '\xfc': 'u',
        '\xdd': 'Y',  '\xfd': 'y', '\xff': 'y',
        '\xc6': 'Ae', '\xe6': 'ae',
        '\xde': 'Th', '\xfe': 'th',
        '\xdf': 'ss'
    };

    /** Used to map characters to HTML entities. */
    var htmlEscapes = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#39;',
        '`': '&#96;'
    };

    /** Used to map HTML entities to characters. */
    var htmlUnescapes = {
        '&amp;': '&',
        '&lt;': '<',
        '&gt;': '>',
        '&quot;': '"',
        '&#39;': "'",
        '&#96;': '`'
    };

    /** Used to determine if values are of the language type `Object`. */
    var objectTypes = {
        'function': true,
        'object': true
    };

    /** Used to escape characters for inclusion in compiled string literals. */
    var stringEscapes = {
        '\\': '\\',
        "'": "'",
        '\n': 'n',
        '\r': 'r',
        '\u2028': 'u2028',
        '\u2029': 'u2029'
    };

    /** Built-in method references without a dependency on `root`. */
    var freeParseFloat = parseFloat,
        freeParseInt = parseInt;

    /** Detect free variable `exports`. */
    var freeExports = (objectTypes[typeof exports] && exports && !exports.nodeType) ? exports : null;

    /** Detect free variable `module`. */
    var freeModule = (objectTypes[typeof module] && module && !module.nodeType) ? module : null;

    /** Detect free variable `global` from Node.js. */
    var freeGlobal = checkGlobal(freeExports && freeModule && typeof global == 'object' && global);

    /** Detect free variable `self`. */
    var freeSelf = checkGlobal(objectTypes[typeof self] && self);

    /** Detect free variable `window`. */
    var freeWindow = checkGlobal(objectTypes[typeof window] && window);

    /** Detect the popular CommonJS extension `module.exports`. */
    var moduleExports = (freeModule && freeModule.exports === freeExports) ? freeExports : null;

    /** Detect `this` as the global object. */
    var thisGlobal = checkGlobal(objectTypes[typeof this] && this);

    /**
     * Used as a reference to the global object.
     *
     * The `this` value is used if it's the global object to avoid Greasemonkey's
     * restricted `window` object, otherwise the `window` object is used.
     */
    var root = freeGlobal || ((freeWindow !== (thisGlobal && thisGlobal.window)) && freeWindow) || freeSelf || thisGlobal || Function('return this')();

    /*--------------------------------------------------------------------------*/

    /**
     * Adds the key-value `pair` to `map`.
     *
     * @private
     * @param {Object} map The map to modify.
     * @param {Array} pair The key-value pair to add.
     * @returns {Object} Returns `map`.
     */
    function addMapEntry(map, pair) {
        map.set(pair[0], pair[1]);
        return map;
    }

    /**
     * Adds `value` to `set`.
     *
     * @private
     * @param {Object} set The set to modify.
     * @param {*} value The value to add.
     * @returns {Object} Returns `set`.
     */
    function addSetEntry(set, value) {
        set.add(value);
        return set;
    }

    /**
     * A faster alternative to `Function#apply`, this function invokes `func`
     * with the `this` binding of `thisArg` and the arguments of `args`.
     *
     * @private
     * @param {Function} func The function to invoke.
     * @param {*} thisArg The `this` binding of `func`.
     * @param {...*} args The arguments to invoke `func` with.
     * @returns {*} Returns the result of `func`.
     */
    function apply(func, thisArg, args) {
        var length = args.length;
        switch (length) {
            case 0: return func.call(thisArg);
            case 1: return func.call(thisArg, args[0]);
            case 2: return func.call(thisArg, args[0], args[1]);
            case 3: return func.call(thisArg, args[0], args[1], args[2]);
        }
        return func.apply(thisArg, args);
    }

    /**
     * A specialized version of `baseAggregator` for arrays.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} setter The function to set `accumulator` values.
     * @param {Function} iteratee The iteratee to transform keys.
     * @param {Object} accumulator The initial aggregated object.
     * @returns {Function} Returns `accumulator`.
     */
    function arrayAggregator(array, setter, iteratee, accumulator) {
        var index = -1,
            length = array.length;

        while (++index < length) {
            var value = array[index];
            setter(accumulator, value, iteratee(value), array);
        }
        return accumulator;
    }

    /**
     * Creates a new array concatenating `array` with `other`.
     *
     * @private
     * @param {Array} array The first array to concatenate.
     * @param {Array} other The second array to concatenate.
     * @returns {Array} Returns the new concatenated array.
     */
    function arrayConcat(array, other) {
        var index = -1,
            length = array.length,
            othIndex = -1,
            othLength = other.length,
            result = Array(length + othLength);

        while (++index < length) {
            result[index] = array[index];
        }
        while (++othIndex < othLength) {
            result[index++] = other[othIndex];
        }
        return result;
    }

    /**
     * A specialized version of `_.forEach` for arrays without support for
     * iteratee shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} iteratee The function invoked per iteration.
     * @returns {Array} Returns `array`.
     */
    function arrayEach(array, iteratee) {
        var index = -1,
            length = array.length;

        while (++index < length) {
            if (iteratee(array[index], index, array) === false) {
                break;
            }
        }
        return array;
    }

    /**
     * A specialized version of `_.forEachRight` for arrays without support for
     * iteratee shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} iteratee The function invoked per iteration.
     * @returns {Array} Returns `array`.
     */
    function arrayEachRight(array, iteratee) {
        var length = array.length;

        while (length--) {
            if (iteratee(array[length], length, array) === false) {
                break;
            }
        }
        return array;
    }

    /**
     * A specialized version of `_.every` for arrays without support for
     * iteratee shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} predicate The function invoked per iteration.
     * @returns {boolean} Returns `true` if all elements pass the predicate check, else `false`.
     */
    function arrayEvery(array, predicate) {
        var index = -1,
            length = array.length;

        while (++index < length) {
            if (!predicate(array[index], index, array)) {
                return false;
            }
        }
        return true;
    }

    /**
     * A specialized version of `_.filter` for arrays without support for
     * iteratee shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} predicate The function invoked per iteration.
     * @returns {Array} Returns the new filtered array.
     */
    function arrayFilter(array, predicate) {
        var index = -1,
            length = array.length,
            resIndex = -1,
            result = [];

        while (++index < length) {
            var value = array[index];
            if (predicate(value, index, array)) {
                result[++resIndex] = value;
            }
        }
        return result;
    }

    /**
     * A specialized version of `_.includes` for arrays without support for
     * specifying an index to search from.
     *
     * @private
     * @param {Array} array The array to search.
     * @param {*} target The value to search for.
     * @returns {boolean} Returns `true` if `target` is found, else `false`.
     */
    function arrayIncludes(array, value) {
        return !!array.length && baseIndexOf(array, value, 0) > -1;
    }

    /**
     * A specialized version of `_.includesWith` for arrays without support for
     * specifying an index to search from.
     *
     * @private
     * @param {Array} array The array to search.
     * @param {*} target The value to search for.
     * @param {Function} comparator The comparator invoked per element.
     * @returns {boolean} Returns `true` if `target` is found, else `false`.
     */
    function arrayIncludesWith(array, value, comparator) {
        var index = -1,
            length = array.length;

        while (++index < length) {
            if (comparator(value, array[index])) {
                return true;
            }
        }
        return false;
    }

    /**
     * A specialized version of `_.map` for arrays without support for iteratee
     * shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} iteratee The function invoked per iteration.
     * @returns {Array} Returns the new mapped array.
     */
    function arrayMap(array, iteratee) {
        var index = -1,
            length = array.length,
            result = Array(length);

        while (++index < length) {
            result[index] = iteratee(array[index], index, array);
        }
        return result;
    }

    /**
     * Appends the elements of `values` to `array`.
     *
     * @private
     * @param {Array} array The array to modify.
     * @param {Array} values The values to append.
     * @returns {Array} Returns `array`.
     */
    function arrayPush(array, values) {
        var index = -1,
            length = values.length,
            offset = array.length;

        while (++index < length) {
            array[offset + index] = values[index];
        }
        return array;
    }

    /**
     * A specialized version of `_.reduce` for arrays without support for
     * iteratee shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} iteratee The function invoked per iteration.
     * @param {*} [accumulator] The initial value.
     * @param {boolean} [initAccum] Specify using the first element of `array` as the initial value.
     * @returns {*} Returns the accumulated value.
     */
    function arrayReduce(array, iteratee, accumulator, initAccum) {
        var index = -1,
            length = array.length;

        if (initAccum && length) {
            accumulator = array[++index];
        }
        while (++index < length) {
            accumulator = iteratee(accumulator, array[index], index, array);
        }
        return accumulator;
    }

    /**
     * A specialized version of `_.reduceRight` for arrays without support for
     * iteratee shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} iteratee The function invoked per iteration.
     * @param {*} [accumulator] The initial value.
     * @param {boolean} [initAccum] Specify using the last element of `array` as the initial value.
     * @returns {*} Returns the accumulated value.
     */
    function arrayReduceRight(array, iteratee, accumulator, initAccum) {
        var length = array.length;
        if (initAccum && length) {
            accumulator = array[--length];
        }
        while (length--) {
            accumulator = iteratee(accumulator, array[length], length, array);
        }
        return accumulator;
    }

    /**
     * A specialized version of `_.some` for arrays without support for iteratee
     * shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} predicate The function invoked per iteration.
     * @returns {boolean} Returns `true` if any element passes the predicate check, else `false`.
     */
    function arraySome(array, predicate) {
        var index = -1,
            length = array.length;

        while (++index < length) {
            if (predicate(array[index], index, array)) {
                return true;
            }
        }
        return false;
    }

    /**
     * The base implementation of methods like `_.max` and `_.min` which accepts a
     * `comparator` to determine the extremum value.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} iteratee The iteratee invoked per iteration.
     * @param {Function} comparator The comparator used to compare values.
     * @returns {*} Returns the extremum value.
     */
    function baseExtremum(array, iteratee, comparator) {
        var index = -1,
            length = array.length;

        while (++index < length) {
            var value = array[index],
                current = iteratee(value);

            if (current != null && (computed === undefined
                        ? current === current
                        : comparator(current, computed)
                )) {
                var computed = current,
                    result = value;
            }
        }
        return result;
    }

    /**
     * The base implementation of methods like `_.find` and `_.findKey`, without
     * support for iteratee shorthands, which iterates over `collection` using
     * `eachFunc`.
     *
     * @private
     * @param {Array|Object} collection The collection to search.
     * @param {Function} predicate The function invoked per iteration.
     * @param {Function} eachFunc The function to iterate over `collection`.
     * @param {boolean} [retKey] Specify returning the key of the found element instead of the element itself.
     * @returns {*} Returns the found element or its key, else `undefined`.
     */
    function baseFind(collection, predicate, eachFunc, retKey) {
        var result;
        eachFunc(collection, function(value, key, collection) {
            if (predicate(value, key, collection)) {
                result = retKey ? key : value;
                return false;
            }
        });
        return result;
    }

    /**
     * The base implementation of `_.findIndex` and `_.findLastIndex` without
     * support for iteratee shorthands.
     *
     * @private
     * @param {Array} array The array to search.
     * @param {Function} predicate The function invoked per iteration.
     * @param {boolean} [fromRight] Specify iterating from right to left.
     * @returns {number} Returns the index of the matched value, else `-1`.
     */
    function baseFindIndex(array, predicate, fromRight) {
        var length = array.length,
            index = fromRight ? length : -1;

        while ((fromRight ? index-- : ++index < length)) {
            if (predicate(array[index], index, array)) {
                return index;
            }
        }
        return -1;
    }

    /**
     * The base implementation of `_.indexOf` without `fromIndex` bounds checks.
     *
     * @private
     * @param {Array} array The array to search.
     * @param {*} value The value to search for.
     * @param {number} fromIndex The index to search from.
     * @returns {number} Returns the index of the matched value, else `-1`.
     */
    function baseIndexOf(array, value, fromIndex) {
        if (value !== value) {
            return indexOfNaN(array, fromIndex);
        }
        var index = fromIndex - 1,
            length = array.length;

        while (++index < length) {
            if (array[index] === value) {
                return index;
            }
        }
        return -1;
    }

    /**
     * The base implementation of `_.reduce` and `_.reduceRight`, without support
     * for iteratee shorthands, which iterates over `collection` using `eachFunc`.
     *
     * @private
     * @param {Array|Object} collection The collection to iterate over.
     * @param {Function} iteratee The function invoked per iteration.
     * @param {*} accumulator The initial value.
     * @param {boolean} initAccum Specify using the first or last element of `collection` as the initial value.
     * @param {Function} eachFunc The function to iterate over `collection`.
     * @returns {*} Returns the accumulated value.
     */
    function baseReduce(collection, iteratee, accumulator, initAccum, eachFunc) {
        eachFunc(collection, function(value, index, collection) {
            accumulator = initAccum
                ? (initAccum = false, value)
                : iteratee(accumulator, value, index, collection);
        });
        return accumulator;
    }

    /**
     * The base implementation of `_.sortBy` which uses `comparer` to define
     * the sort order of `array` and replaces criteria objects with their
     * corresponding values.
     *
     * @private
     * @param {Array} array The array to sort.
     * @param {Function} comparer The function to define sort order.
     * @returns {Array} Returns `array`.
     */
    function baseSortBy(array, comparer) {
        var length = array.length;

        array.sort(comparer);
        while (length--) {
            array[length] = array[length].value;
        }
        return array;
    }

    /**
     * The base implementation of `_.sum` without support for iteratee shorthands.
     *
     * @private
     * @param {Array} array The array to iterate over.
     * @param {Function} iteratee The function invoked per iteration.
     * @returns {number} Returns the sum.
     */
    function baseSum(array, iteratee) {
        var result,
            index = -1,
            length = array.length;

        while (++index < length) {
            var current = iteratee(array[index]);
            if (current !== undefined) {
                result = result === undefined ? current : (result + current);
            }
        }
        return result;
    }

    /**
     * The base implementation of `_.times` without support for iteratee shorthands
     * or max array length checks.
     *
     * @private
     * @param {number} n The number of times to invoke `iteratee`.
     * @param {Function} iteratee The function invoked per iteration.
     * @returns {Array} Returns the array of results.
     */
    function baseTimes(n, iteratee) {
        var index = -1,
            result = Array(n);

        while (++index < n) {
            result[index] = iteratee(index);
        }
        return result;
    }

    /**
     * The base implementation of `_.toPairs` and `_.toPairsIn` which creates an array
     * of key-value pairs for `object` corresponding to the property names of `props`.
     *
     * @private
     * @param {Object} object The object to query.
     * @param {Array} props The property names to get values for.
     * @returns {Object} Returns the new array of key-value pairs.
     */
    function baseToPairs(object, props) {
        return arrayMap(props, function(key) {
            return [key, object[key]];
        });
    }

    /**
     * The base implementation of `_.unary` without support for storing wrapper metadata.
     *
     * @private
     * @param {Function} func The function to cap arguments for.
     * @returns {Function} Returns the new function.
     */
    function baseUnary(func) {
        return function(value) {
            return func(value);
        };
    }

    /**
     * The base implementation of `_.values` and `_.valuesIn` which creates an
     * array of `object` property values corresponding to the property names
     * of `props`.
     *
     * @private
     * @param {Object} object The object to query.
     * @param {Array} props The property names to get values for.
     * @returns {Object} Returns the array of property values.
     */
    function baseValues(object, props) {
        return arrayMap(props, function(key) {
            return object[key];
        });
    }

    /**
     * Used by `_.trim` and `_.trimStart` to get the index of the first string symbol
     * that is not found in the character symbols.
     *
     * @private
     * @param {Array} strSymbols The string symbols to inspect.
     * @param {Array} chrSymbols The character symbols to find.
     * @returns {number} Returns the index of the first unmatched string symbol.
     */
    function charsStartIndex(strSymbols, chrSymbols) {
        var index = -1,
            length = strSymbols.length;

        while (++index < length && baseIndexOf(chrSymbols, strSymbols[index], 0) > -1) {}
        return index;
    }

    /**
     * Used by `_.trim` and `_.trimEnd` to get the index of the last string symbol
     * that is not found in the character symbols.
     *
     * @private
     * @param {Array} strSymbols The string symbols to inspect.
     * @param {Array} chrSymbols The character symbols to find.
     * @returns {number} Returns the index of the last unmatched string symbol.
     */
    function charsEndIndex(strSymbols, chrSymbols) {
        var index = strSymbols.length;

        while (index-- && baseIndexOf(chrSymbols, strSymbols[index], 0) > -1) {}
        return index;
    }

    /**
     * Checks if `value` is a global object.
     *
     * @private
     * @param {*} value The value to check.
     * @returns {null|Object} Returns `value` if it's a global object, else `null`.
     */
    function checkGlobal(value) {
        return (value && value.Object === Object) ? value : null;
    }

    /**
     * Compares values to sort them in ascending order.
     *
     * @private
     * @param {*} value The value to compare.
     * @param {*} other The other value to compare.
     * @returns {number} Returns the sort order indicator for `value`.
     */
    function compareAscending(value, other) {
        if (value !== other) {
            var valIsNull = value === null,
                valIsUndef = value === undefined,
                valIsReflexive = value === value;

            var othIsNull = other === null,
                othIsUndef = other === undefined,
                othIsReflexive = other === other;

            if ((value > other && !othIsNull) || !valIsReflexive ||
                (valIsNull && !othIsUndef && othIsReflexive) ||
                (valIsUndef && othIsReflexive)) {
                return 1;
            }
            if ((value < other && !valIsNull) || !othIsReflexive ||
                (othIsNull && !valIsUndef && valIsReflexive) ||
                (othIsUndef && valIsReflexive)) {
                return -1;
            }
        }
        return 0;
    }

    /**
     * Used by `_.orderBy` to compare multiple properties of a value to another
     * and stable sort them.
     *
     * If `orders` is unspecified, all values are sorted in ascending order. Otherwise,
     * specify an order of "desc" for descending or "asc" for ascending sort order
     * of corresponding values.
     *
     * @private
     * @param {Object} object The object to compare.
     * @param {Object} other The other object to compare.
     * @param {boolean[]|string[]} orders The order to sort by for each property.
     * @returns {number} Returns the sort order indicator for `object`.
     */
    function compareMultiple(object, other, orders) {
        var index = -1,
            objCriteria = object.criteria,
            othCriteria = other.criteria,
            length = objCriteria.length,
            ordersLength = orders.length;

        while (++index < length) {
            var result = compareAscending(objCriteria[index], othCriteria[index]);
            if (result) {
                if (index >= ordersLength) {
                    return result;
                }
                var order = orders[index];
                return result * (order == 'desc' ? -1 : 1);
            }
        }
        // Fixes an `Array#sort` bug in the JS engine embedded in Adobe applications
        // that causes it, under certain circumstances, to provide the same value for
        // `object` and `other`. See https://github.com/jashkenas/underscore/pull/1247
        // for more details.
        //
        // This also ensures a stable sort in V8 and other engines.
        // See https://code.google.com/p/v8/issues/detail?id=90 for more details.
        return object.index - other.index;
    }

    /**
     * Used by `_.deburr` to convert latin-1 supplementary letters to basic latin letters.
     *
     * @private
     * @param {string} letter The matched letter to deburr.
     * @returns {string} Returns the deburred letter.
     */
    function deburrLetter(letter) {
        return deburredLetters[letter];
    }

    /**
     * Used by `_.escape` to convert characters to HTML entities.
     *
     * @private
     * @param {string} chr The matched character to escape.
     * @returns {string} Returns the escaped character.
     */
    function escapeHtmlChar(chr) {
        return htmlEscapes[chr];
    }

    /**
     * Used by `_.template` to escape characters for inclusion in compiled string literals.
     *
     * @private
     * @param {string} chr The matched character to escape.
     * @returns {string} Returns the escaped character.
     */
    function escapeStringChar(chr) {
        return '\\' + stringEscapes[chr];
    }

    /**
     * Gets the index at which the first occurrence of `NaN` is found in `array`.
     *
     * @private
     * @param {Array} array The array to search.
     * @param {number} fromIndex The index to search from.
     * @param {boolean} [fromRight] Specify iterating from right to left.
     * @returns {number} Returns the index of the matched `NaN`, else `-1`.
     */
    function indexOfNaN(array, fromIndex, fromRight) {
        var length = array.length,
            index = fromIndex + (fromRight ? 0 : -1);

        while ((fromRight ? index-- : ++index < length)) {
            var other = array[index];
            if (other !== other) {
                return index;
            }
        }
        return -1;
    }

    /**
     * Checks if `value` is a host object in IE < 9.
     *
     * @private
     * @param {*} value The value to check.
     * @returns {boolean} Returns `true` if `value` is a host object, else `false`.
     */
    function isHostObject(value) {
        // Many host objects are `Object` objects that can coerce to strings
        // despite having improperly defined `toString` methods.
        var result = false;
        if (value != null && typeof value.toString != 'function') {
            try {
                result = !!(value + '');
            } catch (e) {}
        }
        return result;
    }

    /**
     * Checks if `value` is a valid array-like index.
     *
     * @private
     * @param {*} value The value to check.
     * @param {number} [length=MAX_SAFE_INTEGER] The upper bounds of a valid index.
     * @returns {boolean} Returns `true` if `value` is a valid index, else `false`.
     */
    function isIndex(value, length) {
        value = (typeof value == 'number' || reIsUint.test(value)) ? +value : -1;
        length = length == null ? MAX_SAFE_INTEGER : length;
        return value > -1 && value % 1 == 0 && value < length;
    }

    /**
     * Converts `iterator` to an array.
     *
     * @private
     * @param {Object} iterator The iterator to convert.
     * @returns {Array} Returns the converted array.
     */
    function iteratorToArray(iterator) {
        var data,
            result = [];

        while (!(data = iterator.next()).done) {
            result.push(data.value);
        }
        return result;
    }

    /**
     * Converts `map` to an array.
     *
     * @private
     * @param {Object} map The map to convert.
     * @returns {Array} Returns the converted array.
     */
    function mapToArray(map) {
        var index = -1,
            result = Array(map.size);

        map.forEach(function(value, key) {
            result[++index] = [key, value];
        });
        return result;
    }

    /**
     * Replaces all `placeholder` elements in `array` with an internal placeholder
     * and returns an array of their indexes.
     *
     * @private
     * @param {Array} array The array to modify.
     * @param {*} placeholder The placeholder to replace.
     * @returns {Array} Returns the new array of placeholder indexes.
     */
    function replaceHolders(array, placeholder) {
        var index = -1,
            length = array.length,
            resIndex = -1,
            result = [];

        while (++index < length) {
            if (array[index] === placeholder) {
                array[index] = PLACEHOLDER;
                result[++resIndex] = index;
            }
        }
        return result;
    }

    /**
     * Converts `set` to an array.
     *
     * @private
     * @param {Object} set The set to convert.
     * @returns {Array} Returns the converted array.
     */
    function setToArray(set) {
        var index = -1,
            result = Array(set.size);

        set.forEach(function(value) {
            result[++index] = value;
        });
        return result;
    }

    /**
     * Gets the number of symbols in `string`.
     *
     * @private
     * @param {string} string The string to inspect.
     * @returns {number} Returns the string size.
     */
    function stringSize(string) {
        if (!(string && reHasComplexSymbol.test(string))) {
            return string.length;
        }
        var result = reComplexSymbol.lastIndex = 0;
        while (reComplexSymbol.test(string)) {
            result++;
        }
        return result;
    }

    /**
     * Converts `string` to an array.
     *
     * @private
     * @param {string} string The string to convert.
     * @returns {Array} Returns the converted array.
     */
    function stringToArray(string) {
        return string.match(reComplexSymbol);
    }

    /**
     * Used by `_.unescape` to convert HTML entities to characters.
     *
     * @private
     * @param {string} chr The matched character to unescape.
     * @returns {string} Returns the unescaped character.
     */
    function unescapeHtmlChar(chr) {
        return htmlUnescapes[chr];
    }

    /*--------------------------------------------------------------------------*/

    /**
     * Create a new pristine `lodash` function using the `context` object.
     *
     * @static
     * @memberOf _
     * @category Util
     * @param {Object} [context=root] The context object.
     * @returns {Function} Returns a new `lodash` function.
     * @example
     *
     * _.mixin({ 'foo': _.constant('foo') });
     *
     * var lodash = _.runInContext();
     * lodash.mixin({ 'bar': lodash.constant('bar') });
     *
     * _.isFunction(_.foo);
     * // => true
     * _.isFunction(_.bar);
     * // => false
     *
     * lodash.isFunction(lodash.foo);
     * // => false
     * lodash.isFunction(lodash.bar);
     * // => true
     *
     * // Use `context` to mock `Date#getTime` use in `_.now`.
     * var mock = _.runInContext({
   *   'Date': function() {
   *     return { 'getTime': getTimeMock };
   *   }
   * });
     *
     * // Create a suped-up `defer` in Node.js.
     * var defer = _.runInContext({ 'setTimeout': setImmediate }).defer;
     */
    function runInContext(context) {
        context = context ? _.defaults({}, context, _.pick(root, contextProps)) : root;

        /** Built-in constructor references. */
        var Date = context.Date,
            Error = context.Error,
            Math = context.Math,
            RegExp = context.RegExp,
            TypeError = context.TypeError;

        /** Used for built-in method references. */
        var arrayProto = context.Array.prototype,
            objectProto = context.Object.prototype;

        /** Used to resolve the decompiled source of functions. */
        var funcToString = context.Function.prototype.toString;

        /** Used to check objects for own properties. */
        var hasOwnProperty = objectProto.hasOwnProperty;

        /** Used to generate unique IDs. */
        var idCounter = 0;

        /** Used to infer the `Object` constructor. */
        var objectCtorString = funcToString.call(Object);

        /**
         * Used to resolve the [`toStringTag`](http://ecma-international.org/ecma-262/6.0/#sec-object.prototype.tostring)
         * of values.
         */
        var objectToString = objectProto.toString;

        /** Used to restore the original `_` reference in `_.noConflict`. */
        var oldDash = root._;

        /** Used to detect if a method is native. */
        var reIsNative = RegExp('^' +
            funcToString.call(hasOwnProperty).replace(reRegExpChar, '\\$&')
                .replace(/hasOwnProperty|(function).*?(?=\\\()| for .+?(?=\\\])/g, '$1.*?') + '$'
        );

        /** Built-in value references. */
        var Buffer = moduleExports ? context.Buffer : undefined,
            Reflect = context.Reflect,
            Symbol = context.Symbol,
            Uint8Array = context.Uint8Array,
            clearTimeout = context.clearTimeout,
            enumerate = Reflect ? Reflect.enumerate : undefined,
            getPrototypeOf = Object.getPrototypeOf,
            getOwnPropertySymbols = Object.getOwnPropertySymbols,
            iteratorSymbol = typeof (iteratorSymbol = Symbol && Symbol.iterator) == 'symbol' ? iteratorSymbol : undefined,
            propertyIsEnumerable = objectProto.propertyIsEnumerable,
            setTimeout = context.setTimeout,
            splice = arrayProto.splice;

        /* Built-in method references for those with the same name as other `lodash` methods. */
        var nativeCeil = Math.ceil,
            nativeFloor = Math.floor,
            nativeIsFinite = context.isFinite,
            nativeJoin = arrayProto.join,
            nativeKeys = Object.keys,
            nativeMax = Math.max,
            nativeMin = Math.min,
            nativeParseInt = context.parseInt,
            nativeRandom = Math.random,
            nativeReverse = arrayProto.reverse;

        /* Built-in method references that are verified to be native. */
        var Map = getNative(context, 'Map'),
            Set = getNative(context, 'Set'),
            WeakMap = getNative(context, 'WeakMap'),
            nativeCreate = getNative(Object, 'create');

        /** Used to store function metadata. */
        var metaMap = WeakMap && new WeakMap;

        /** Used to detect maps, sets, and weakmaps. */
        var mapCtorString = Map ? funcToString.call(Map) : '',
            setCtorString = Set ? funcToString.call(Set) : '',
            weakMapCtorString = WeakMap ? funcToString.call(WeakMap) : '';

        /** Used to convert symbols to primitives and strings. */
        var symbolProto = Symbol ? Symbol.prototype : undefined,
            symbolValueOf = Symbol ? symbolProto.valueOf : undefined,
            symbolToString = Symbol ? symbolProto.toString : undefined;

        /** Used to lookup unminified function names. */
        var realNames = {};

        /*------------------------------------------------------------------------*/

        /**
         * Creates a `lodash` object which wraps `value` to enable implicit method
         * chaining. Methods that operate on and return arrays, collections, and
         * functions can be chained together. Methods that retrieve a single value or
         * may return a primitive value will automatically end the chain sequence and
         * return the unwrapped value. Otherwise, the value must be unwrapped with
         * `_#value`.
         *
         * Explicit chaining, which must be unwrapped with `_#value` in all cases,
         * may be enabled using `_.chain`.
         *
         * The execution of chained methods is lazy, that is, it's deferred until
         * `_#value` is implicitly or explicitly called.
         *
         * Lazy evaluation allows several methods to support shortcut fusion. Shortcut
         * fusion is an optimization to merge iteratee calls; this avoids the creation
         * of intermediate arrays and can greatly reduce the number of iteratee executions.
         * Sections of a chain sequence qualify for shortcut fusion if the section is
         * applied to an array of at least two hundred elements and any iteratees
         * accept only one argument. The heuristic for whether a section qualifies
         * for shortcut fusion is subject to change.
         *
         * Chaining is supported in custom builds as long as the `_#value` method is
         * directly or indirectly included in the build.
         *
         * In addition to lodash methods, wrappers have `Array` and `String` methods.
         *
         * The wrapper `Array` methods are:
         * `concat`, `join`, `pop`, `push`, `shift`, `sort`, `splice`, and `unshift`
         *
         * The wrapper `String` methods are:
         * `replace` and `split`
         *
         * The wrapper methods that support shortcut fusion are:
         * `at`, `compact`, `drop`, `dropRight`, `dropWhile`, `filter`, `find`,
         * `findLast`, `head`, `initial`, `last`, `map`, `reject`, `reverse`, `slice`,
         * `tail`, `take`, `takeRight`, `takeRightWhile`, `takeWhile`, and `toArray`
         *
         * The chainable wrapper methods are:
         * `after`, `ary`, `assign`, `assignIn`, `assignInWith`, `assignWith`,
         * `at`, `before`, `bind`, `bindAll`, `bindKey`, `chain`, `chunk`, `commit`,
         * `compact`, `concat`, `conforms`, `constant`, `countBy`, `create`, `curry`,
         * `debounce`, `defaults`, `defaultsDeep`, `defer`, `delay`, `difference`,
         * `differenceBy`, `differenceWith`, `drop`, `dropRight`, `dropRightWhile`,
         * `dropWhile`, `fill`, `filter`, `flatten`, `flattenDeep`, `flip`, `flow`,
         * `flowRight`, `fromPairs`, `functions`, `functionsIn`, `groupBy`, `initial`,
         * `intersection`, `intersectionBy`, `intersectionWith`, `invert`, `invertBy`,
         * `invokeMap`, `iteratee`, `keyBy`, `keys`, `keysIn`, `map`, `mapKeys`,
         * `mapValues`, `matches`, `matchesProperty`, `memoize`, `merge`, `mergeWith`,
         * `method`, `methodOf`, `mixin`, `negate`, `nthArg`, `omit`, `omitBy`, `once`,
         * `orderBy`, `over`, `overArgs`, `overEvery`, `overSome`, `partial`,
         * `partialRight`, `partition`, `pick`, `pickBy`, `plant`, `property`,
         * `propertyOf`, `pull`, `pullAll`, `pullAllBy`, `pullAt`, `push`, `range`,
         * `rangeRight`, `rearg`, `reject`, `remove`, `rest`, `reverse`, `sampleSize`,
         * `set`, `setWith`, `shuffle`, `slice`, `sort`, `sortBy`, `splice`, `spread`,
         * `tail`, `take`, `takeRight`, `takeRightWhile`, `takeWhile`, `tap`, `throttle`,
         * `thru`, `toArray`, `toPairs`, `toPairsIn`, `toPath`, `toPlainObject`,
         * `transform`, `unary`, `union`, `unionBy`, `unionWith`, `uniq`, `uniqBy`,
         * `uniqWith`, `unset`, `unshift`, `unzip`, `unzipWith`, `values`, `valuesIn`,
         * `without`, `wrap`, `xor`, `xorBy`, `xorWith`, `zip`, `zipObject`,
         * `zipObjectDeep`, and `zipWith`
         *
         * The wrapper methods that are **not** chainable by default are:
         * `add`, `attempt`, `camelCase`, `capitalize`, `ceil`, `clamp`, `clone`,
         * `cloneDeep`, `cloneDeepWith`, `cloneWith`, `deburr`, `endsWith`, `eq`,
         * `escape`, `escapeRegExp`, `every`, `find`, `findIndex`, `findKey`,
         * `findLast`, `findLastIndex`, `findLastKey`, `floor`, `forEach`, `forEachRight`,
         * `forIn`, `forInRight`, `forOwn`, `forOwnRight`, `get`, `gt`, `gte`, `has`,
         * `hasIn`, `head`, `identity`, `includes`, `indexOf`, `inRange`, `invoke`,
         * `isArguments`, `isArray`, `isArrayLike`, `isArrayLikeObject`, `isBoolean`,
         * `isDate`, `isElement`, `isEmpty`, `isEqual`, `isEqualWith`, `isError`,
         * `isFinite`, `isFunction`, `isInteger`, `isLength`, `isMatch`, `isMatchWith`,
         * `isNaN`, `isNative`, `isNil`, `isNull`, `isNumber`, `isObject`, `isObjectLike`,
         * `isPlainObject`, `isRegExp`, `isSafeInteger`, `isString`, `isUndefined`,
         * `isTypedArray`, `join`, `kebabCase`, `last`, `lastIndexOf`, `lowerCase`,
         * `lowerFirst`, `lt`, `lte`, `max`, `maxBy`, `mean`, `min`, `minBy`,
         * `noConflict`, `noop`, `now`, `pad`, `padEnd`, `padStart`, `parseInt`,
         * `pop`, `random`, `reduce`, `reduceRight`, `repeat`, `result`, `round`,
         * `runInContext`, `sample`, `shift`, `size`, `snakeCase`, `some`, `sortedIndex`,
         * `sortedIndexBy`, `sortedLastIndex`, `sortedLastIndexBy`, `startCase`,
         * `startsWith`, `subtract`, `sum`, `sumBy`, `template`, `times`, `toLower`,
         * `toInteger`, `toLength`, `toNumber`, `toSafeInteger`, `toString`, `toUpper`,
         * `trim`, `trimEnd`, `trimStart`, `truncate`, `unescape`, `uniqueId`,
         * `upperCase`, `upperFirst`, `value`, and `words`
         *
         * @name _
         * @constructor
         * @category Seq
         * @param {*} value The value to wrap in a `lodash` instance.
         * @returns {Object} Returns the new `lodash` wrapper instance.
         * @example
         *
         * function square(n) {
     *   return n * n;
     * }
         *
         * var wrapped = _([1, 2, 3]);
         *
         * // Returns an unwrapped value.
         * wrapped.reduce(_.add);
         * // => 6
         *
         * // Returns a wrapped value.
         * var squares = wrapped.map(square);
         *
         * _.isArray(squares);
         * // => false
         *
         * _.isArray(squares.value());
         * // => true
         */
        function lodash(value) {
            if (isObjectLike(value) && !isArray(value) && !(value instanceof LazyWrapper)) {
                if (value instanceof LodashWrapper) {
                    return value;
                }
                if (hasOwnProperty.call(value, '__wrapped__')) {
                    return wrapperClone(value);
                }
            }
            return new LodashWrapper(value);
        }

        /**
         * The function whose prototype all chaining wrappers inherit from.
         *
         * @private
         */
        function baseLodash() {
            // No operation performed.
        }

        /**
         * The base constructor for creating `lodash` wrapper objects.
         *
         * @private
         * @param {*} value The value to wrap.
         * @param {boolean} [chainAll] Enable chaining for all wrapper methods.
         */
        function LodashWrapper(value, chainAll) {
            this.__wrapped__ = value;
            this.__actions__ = [];
            this.__chain__ = !!chainAll;
            this.__index__ = 0;
            this.__values__ = undefined;
        }

        /**
         * By default, the template delimiters used by lodash are like those in
         * embedded Ruby (ERB). Change the following template settings to use
         * alternative delimiters.
         *
         * @static
         * @memberOf _
         * @type Object
         */
        lodash.templateSettings = {

            /**
             * Used to detect `data` property values to be HTML-escaped.
             *
             * @memberOf _.templateSettings
             * @type RegExp
             */
            'escape': reEscape,

            /**
             * Used to detect code to be evaluated.
             *
             * @memberOf _.templateSettings
             * @type RegExp
             */
            'evaluate': reEvaluate,

            /**
             * Used to detect `data` property values to inject.
             *
             * @memberOf _.templateSettings
             * @type RegExp
             */
            'interpolate': reInterpolate,

            /**
             * Used to reference the data object in the template text.
             *
             * @memberOf _.templateSettings
             * @type string
             */
            'variable': '',

            /**
             * Used to import variables into the compiled template.
             *
             * @memberOf _.templateSettings
             * @type Object
             */
            'imports': {

                /**
                 * A reference to the `lodash` function.
                 *
                 * @memberOf _.templateSettings.imports
                 * @type Function
                 */
                '_': lodash
            }
        };

        /*------------------------------------------------------------------------*/

        /**
         * Creates a lazy wrapper object which wraps `value` to enable lazy evaluation.
         *
         * @private
         * @param {*} value The value to wrap.
         */
        function LazyWrapper(value) {
            this.__wrapped__ = value;
            this.__actions__ = [];
            this.__dir__ = 1;
            this.__filtered__ = false;
            this.__iteratees__ = [];
            this.__takeCount__ = MAX_ARRAY_LENGTH;
            this.__views__ = [];
        }

        /**
         * Creates a clone of the lazy wrapper object.
         *
         * @private
         * @name clone
         * @memberOf LazyWrapper
         * @returns {Object} Returns the cloned `LazyWrapper` object.
         */
        function lazyClone() {
            var result = new LazyWrapper(this.__wrapped__);
            result.__actions__ = copyArray(this.__actions__);
            result.__dir__ = this.__dir__;
            result.__filtered__ = this.__filtered__;
            result.__iteratees__ = copyArray(this.__iteratees__);
            result.__takeCount__ = this.__takeCount__;
            result.__views__ = copyArray(this.__views__);
            return result;
        }

        /**
         * Reverses the direction of lazy iteration.
         *
         * @private
         * @name reverse
         * @memberOf LazyWrapper
         * @returns {Object} Returns the new reversed `LazyWrapper` object.
         */
        function lazyReverse() {
            if (this.__filtered__) {
                var result = new LazyWrapper(this);
                result.__dir__ = -1;
                result.__filtered__ = true;
            } else {
                result = this.clone();
                result.__dir__ *= -1;
            }
            return result;
        }

        /**
         * Extracts the unwrapped value from its lazy wrapper.
         *
         * @private
         * @name value
         * @memberOf LazyWrapper
         * @returns {*} Returns the unwrapped value.
         */
        function lazyValue() {
            var array = this.__wrapped__.value(),
                dir = this.__dir__,
                isArr = isArray(array),
                isRight = dir < 0,
                arrLength = isArr ? array.length : 0,
                view = getView(0, arrLength, this.__views__),
                start = view.start,
                end = view.end,
                length = end - start,
                index = isRight ? end : (start - 1),
                iteratees = this.__iteratees__,
                iterLength = iteratees.length,
                resIndex = 0,
                takeCount = nativeMin(length, this.__takeCount__);

            if (!isArr || arrLength < LARGE_ARRAY_SIZE || (arrLength == length && takeCount == length)) {
                return baseWrapperValue(array, this.__actions__);
            }
            var result = [];

            outer:
                while (length-- && resIndex < takeCount) {
                    index += dir;

                    var iterIndex = -1,
                        value = array[index];

                    while (++iterIndex < iterLength) {
                        var data = iteratees[iterIndex],
                            iteratee = data.iteratee,
                            type = data.type,
                            computed = iteratee(value);

                        if (type == LAZY_MAP_FLAG) {
                            value = computed;
                        } else if (!computed) {
                            if (type == LAZY_FILTER_FLAG) {
                                continue outer;
                            } else {
                                break outer;
                            }
                        }
                    }
                    result[resIndex++] = value;
                }
            return result;
        }

        /*------------------------------------------------------------------------*/

        /**
         * Creates an hash object.
         *
         * @private
         * @returns {Object} Returns the new hash object.
         */
        function Hash() {}

        /**
         * Removes `key` and its value from the hash.
         *
         * @private
         * @param {Object} hash The hash to modify.
         * @param {string} key The key of the value to remove.
         * @returns {boolean} Returns `true` if the entry was removed, else `false`.
         */
        function hashDelete(hash, key) {
            return hashHas(hash, key) && delete hash[key];
        }

        /**
         * Gets the hash value for `key`.
         *
         * @private
         * @param {Object} hash The hash to query.
         * @param {string} key The key of the value to get.
         * @returns {*} Returns the entry value.
         */
        function hashGet(hash, key) {
            if (nativeCreate) {
                var result = hash[key];
                return result === HASH_UNDEFINED ? undefined : result;
            }
            return hasOwnProperty.call(hash, key) ? hash[key] : undefined;
        }

        /**
         * Checks if a hash value for `key` exists.
         *
         * @private
         * @param {Object} hash The hash to query.
         * @param {string} key The key of the entry to check.
         * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
         */
        function hashHas(hash, key) {
            return nativeCreate ? hash[key] !== undefined : hasOwnProperty.call(hash, key);
        }

        /**
         * Sets the hash `key` to `value`.
         *
         * @private
         * @param {Object} hash The hash to modify.
         * @param {string} key The key of the value to set.
         * @param {*} value The value to set.
         */
        function hashSet(hash, key, value) {
            hash[key] = (nativeCreate && value === undefined) ? HASH_UNDEFINED : value;
        }

        /*------------------------------------------------------------------------*/

        /**
         * Creates a map cache object to store key-value pairs.
         *
         * @private
         * @param {Array} [values] The values to cache.
         */
        function MapCache(values) {
            var index = -1,
                length = values ? values.length : 0;

            this.clear();
            while (++index < length) {
                var entry = values[index];
                this.set(entry[0], entry[1]);
            }
        }

        /**
         * Removes all key-value entries from the map.
         *
         * @private
         * @name clear
         * @memberOf MapCache
         */
        function mapClear() {
            this.__data__ = { 'hash': new Hash, 'map': Map ? new Map : [], 'string': new Hash };
        }

        /**
         * Removes `key` and its value from the map.
         *
         * @private
         * @name delete
         * @memberOf MapCache
         * @param {string} key The key of the value to remove.
         * @returns {boolean} Returns `true` if the entry was removed, else `false`.
         */
        function mapDelete(key) {
            var data = this.__data__;
            if (isKeyable(key)) {
                return hashDelete(typeof key == 'string' ? data.string : data.hash, key);
            }
            return Map ? data.map['delete'](key) : assocDelete(data.map, key);
        }

        /**
         * Gets the map value for `key`.
         *
         * @private
         * @name get
         * @memberOf MapCache
         * @param {string} key The key of the value to get.
         * @returns {*} Returns the entry value.
         */
        function mapGet(key) {
            var data = this.__data__;
            if (isKeyable(key)) {
                return hashGet(typeof key == 'string' ? data.string : data.hash, key);
            }
            return Map ? data.map.get(key) : assocGet(data.map, key);
        }

        /**
         * Checks if a map value for `key` exists.
         *
         * @private
         * @name has
         * @memberOf MapCache
         * @param {string} key The key of the entry to check.
         * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
         */
        function mapHas(key) {
            var data = this.__data__;
            if (isKeyable(key)) {
                return hashHas(typeof key == 'string' ? data.string : data.hash, key);
            }
            return Map ? data.map.has(key) : assocHas(data.map, key);
        }

        /**
         * Sets the map `key` to `value`.
         *
         * @private
         * @name set
         * @memberOf MapCache
         * @param {string} key The key of the value to set.
         * @param {*} value The value to set.
         * @returns {Object} Returns the map cache object.
         */
        function mapSet(key, value) {
            var data = this.__data__;
            if (isKeyable(key)) {
                hashSet(typeof key == 'string' ? data.string : data.hash, key, value);
            } else if (Map) {
                data.map.set(key, value);
            } else {
                assocSet(data.map, key, value);
            }
            return this;
        }

        /*------------------------------------------------------------------------*/

        /**
         *
         * Creates a set cache object to store unique values.
         *
         * @private
         * @param {Array} [values] The values to cache.
         */
        function SetCache(values) {
            var index = -1,
                length = values ? values.length : 0;

            this.__data__ = new MapCache;
            while (++index < length) {
                this.push(values[index]);
            }
        }

        /**
         * Checks if `value` is in `cache`.
         *
         * @private
         * @param {Object} cache The set cache to search.
         * @param {*} value The value to search for.
         * @returns {number} Returns `true` if `value` is found, else `false`.
         */
        function cacheHas(cache, value) {
            var map = cache.__data__;
            if (isKeyable(value)) {
                var data = map.__data__,
                    hash = typeof value == 'string' ? data.string : data.hash;

                return hash[value] === HASH_UNDEFINED;
            }
            return map.has(value);
        }

        /**
         * Adds `value` to the set cache.
         *
         * @private
         * @name push
         * @memberOf SetCache
         * @param {*} value The value to cache.
         */
        function cachePush(value) {
            var map = this.__data__;
            if (isKeyable(value)) {
                var data = map.__data__,
                    hash = typeof value == 'string' ? data.string : data.hash;

                hash[value] = HASH_UNDEFINED;
            }
            else {
                map.set(value, HASH_UNDEFINED);
            }
        }

        /*------------------------------------------------------------------------*/

        /**
         * Creates a stack cache object to store key-value pairs.
         *
         * @private
         * @param {Array} [values] The values to cache.
         */
        function Stack(values) {
            var index = -1,
                length = values ? values.length : 0;

            this.clear();
            while (++index < length) {
                var entry = values[index];
                this.set(entry[0], entry[1]);
            }
        }

        /**
         * Removes all key-value entries from the stack.
         *
         * @private
         * @name clear
         * @memberOf Stack
         */
        function stackClear() {
            this.__data__ = { 'array': [], 'map': null };
        }

        /**
         * Removes `key` and its value from the stack.
         *
         * @private
         * @name delete
         * @memberOf Stack
         * @param {string} key The key of the value to remove.
         * @returns {boolean} Returns `true` if the entry was removed, else `false`.
         */
        function stackDelete(key) {
            var data = this.__data__,
                array = data.array;

            return array ? assocDelete(array, key) : data.map['delete'](key);
        }

        /**
         * Gets the stack value for `key`.
         *
         * @private
         * @name get
         * @memberOf Stack
         * @param {string} key The key of the value to get.
         * @returns {*} Returns the entry value.
         */
        function stackGet(key) {
            var data = this.__data__,
                array = data.array;

            return array ? assocGet(array, key) : data.map.get(key);
        }

        /**
         * Checks if a stack value for `key` exists.
         *
         * @private
         * @name has
         * @memberOf Stack
         * @param {string} key The key of the entry to check.
         * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
         */
        function stackHas(key) {
            var data = this.__data__,
                array = data.array;

            return array ? assocHas(array, key) : data.map.has(key);
        }

        /**
         * Sets the stack `key` to `value`.
         *
         * @private
         * @name set
         * @memberOf Stack
         * @param {string} key The key of the value to set.
         * @param {*} value The value to set.
         * @returns {Object} Returns the stack cache object.
         */
        function stackSet(key, value) {
            var data = this.__data__,
                array = data.array;

            if (array) {
                if (array.length < (LARGE_ARRAY_SIZE - 1)) {
                    assocSet(array, key, value);
                } else {
                    data.array = null;
                    data.map = new MapCache(array);
                }
            }
            var map = data.map;
            if (map) {
                map.set(key, value);
            }
            return this;
        }

        /*------------------------------------------------------------------------*/

        /**
         * Removes `key` and its value from the associative array.
         *
         * @private
         * @param {Array} array The array to query.
         * @param {string} key The key of the value to remove.
         * @returns {boolean} Returns `true` if the entry was removed, else `false`.
         */
        function assocDelete(array, key) {
            var index = assocIndexOf(array, key);
            if (index < 0) {
                return false;
            }
            var lastIndex = array.length - 1;
            if (index == lastIndex) {
                array.pop();
            } else {
                splice.call(array, index, 1);
            }
            return true;
        }

        /**
         * Gets the associative array value for `key`.
         *
         * @private
         * @param {Array} array The array to query.
         * @param {string} key The key of the value to get.
         * @returns {*} Returns the entry value.
         */
        function assocGet(array, key) {
            var index = assocIndexOf(array, key);
            return index < 0 ? undefined : array[index][1];
        }

        /**
         * Checks if an associative array value for `key` exists.
         *
         * @private
         * @param {Array} array The array to query.
         * @param {string} key The key of the entry to check.
         * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
         */
        function assocHas(array, key) {
            return assocIndexOf(array, key) > -1;
        }

        /**
         * Gets the index at which the first occurrence of `key` is found in `array`
         * of key-value pairs.
         *
         * @private
         * @param {Array} array The array to search.
         * @param {*} key The key to search for.
         * @returns {number} Returns the index of the matched value, else `-1`.
         */
        function assocIndexOf(array, key) {
            var length = array.length;
            while (length--) {
                if (eq(array[length][0], key)) {
                    return length;
                }
            }
            return -1;
        }

        /**
         * Sets the associative array `key` to `value`.
         *
         * @private
         * @param {Array} array The array to modify.
         * @param {string} key The key of the value to set.
         * @param {*} value The value to set.
         */
        function assocSet(array, key, value) {
            var index = assocIndexOf(array, key);
            if (index < 0) {
                array.push([key, value]);
            } else {
                array[index][1] = value;
            }
        }

        /*------------------------------------------------------------------------*/

        /**
         * Used by `_.defaults` to customize its `_.assignIn` use.
         *
         * @private
         * @param {*} objValue The destination value.
         * @param {*} srcValue The source value.
         * @param {string} key The key of the property to assign.
         * @param {Object} object The parent object of `objValue`.
         * @returns {*} Returns the value to assign.
         */
        function assignInDefaults(objValue, srcValue, key, object) {
            if (objValue === undefined ||
                (eq(objValue, objectProto[key]) && !hasOwnProperty.call(object, key))) {
                return srcValue;
            }
            return objValue;
        }

        /**
         * This function is like `assignValue` except that it doesn't assign `undefined` values.
         *
         * @private
         * @param {Object} object The object to modify.
         * @param {string} key The key of the property to assign.
         * @param {*} value The value to assign.
         */
        function assignMergeValue(object, key, value) {
            if ((value !== undefined && !eq(object[key], value)) ||
                (typeof key == 'number' && value === undefined && !(key in object))) {
                object[key] = value;
            }
        }

        /**
         * Assigns `value` to `key` of `object` if the existing value is not equivalent
         * using [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * for equality comparisons.
         *
         * @private
         * @param {Object} object The object to modify.
         * @param {string} key The key of the property to assign.
         * @param {*} value The value to assign.
         */
        function assignValue(object, key, value) {
            var objValue = object[key];
            if ((!eq(objValue, value) ||
                (eq(objValue, objectProto[key]) && !hasOwnProperty.call(object, key))) ||
                (value === undefined && !(key in object))) {
                object[key] = value;
            }
        }

        /**
         * Aggregates elements of `collection` on `accumulator` with keys transformed
         * by `iteratee` and values set by `setter`.
         *
         * @private
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} setter The function to set `accumulator` values.
         * @param {Function} iteratee The iteratee to transform keys.
         * @param {Object} accumulator The initial aggregated object.
         * @returns {Function} Returns `accumulator`.
         */
        function baseAggregator(collection, setter, iteratee, accumulator) {
            baseEach(collection, function(value, key, collection) {
                setter(accumulator, value, iteratee(value), collection);
            });
            return accumulator;
        }

        /**
         * The base implementation of `_.assign` without support for multiple sources
         * or `customizer` functions.
         *
         * @private
         * @param {Object} object The destination object.
         * @param {Object} source The source object.
         * @returns {Object} Returns `object`.
         */
        function baseAssign(object, source) {
            return object && copyObject(source, keys(source), object);
        }

        /**
         * The base implementation of `_.at` without support for individual paths.
         *
         * @private
         * @param {Object} object The object to iterate over.
         * @param {string[]} paths The property paths of elements to pick.
         * @returns {Array} Returns the new array of picked elements.
         */
        function baseAt(object, paths) {
            var index = -1,
                isNil = object == null,
                length = paths.length,
                result = Array(length);

            while (++index < length) {
                result[index] = isNil ? undefined : get(object, paths[index]);
            }
            return result;
        }

        /**
         * The base implementation of `_.clamp` which doesn't coerce arguments to numbers.
         *
         * @private
         * @param {number} number The number to clamp.
         * @param {number} [lower] The lower bound.
         * @param {number} upper The upper bound.
         * @returns {number} Returns the clamped number.
         */
        function baseClamp(number, lower, upper) {
            if (number === number) {
                if (upper !== undefined) {
                    number = number <= upper ? number : upper;
                }
                if (lower !== undefined) {
                    number = number >= lower ? number : lower;
                }
            }
            return number;
        }

        /**
         * The base implementation of `_.clone` and `_.cloneDeep` which tracks
         * traversed objects.
         *
         * @private
         * @param {*} value The value to clone.
         * @param {boolean} [isDeep] Specify a deep clone.
         * @param {Function} [customizer] The function to customize cloning.
         * @param {string} [key] The key of `value`.
         * @param {Object} [object] The parent object of `value`.
         * @param {Object} [stack] Tracks traversed objects and their clone counterparts.
         * @returns {*} Returns the cloned value.
         */
        function baseClone(value, isDeep, customizer, key, object, stack) {
            var result;
            if (customizer) {
                result = object ? customizer(value, key, object, stack) : customizer(value);
            }
            if (result !== undefined) {
                return result;
            }
            if (!isObject(value)) {
                return value;
            }
            var isArr = isArray(value);
            if (isArr) {
                result = initCloneArray(value);
                if (!isDeep) {
                    return copyArray(value, result);
                }
            } else {
                var tag = getTag(value),
                    isFunc = tag == funcTag || tag == genTag;

                if (isBuffer(value)) {
                    return cloneBuffer(value, isDeep);
                }
                if (tag == objectTag || tag == argsTag || (isFunc && !object)) {
                    if (isHostObject(value)) {
                        return object ? value : {};
                    }
                    result = initCloneObject(isFunc ? {} : value);
                    if (!isDeep) {
                        return copySymbols(value, baseAssign(result, value));
                    }
                } else {
                    return cloneableTags[tag]
                        ? initCloneByTag(value, tag, isDeep)
                        : (object ? value : {});
                }
            }
            // Check for circular references and return its corresponding clone.
            stack || (stack = new Stack);
            var stacked = stack.get(value);
            if (stacked) {
                return stacked;
            }
            stack.set(value, result);

            // Recursively populate clone (susceptible to call stack limits).
            (isArr ? arrayEach : baseForOwn)(value, function(subValue, key) {
                assignValue(result, key, baseClone(subValue, isDeep, customizer, key, value, stack));
            });
            return isArr ? result : copySymbols(value, result);
        }

        /**
         * The base implementation of `_.conforms` which doesn't clone `source`.
         *
         * @private
         * @param {Object} source The object of property predicates to conform to.
         * @returns {Function} Returns the new function.
         */
        function baseConforms(source) {
            var props = keys(source),
                length = props.length;

            return function(object) {
                if (object == null) {
                    return !length;
                }
                var index = length;
                while (index--) {
                    var key = props[index],
                        predicate = source[key],
                        value = object[key];

                    if ((value === undefined && !(key in Object(object))) || !predicate(value)) {
                        return false;
                    }
                }
                return true;
            };
        }

        /**
         * The base implementation of `_.create` without support for assigning
         * properties to the created object.
         *
         * @private
         * @param {Object} prototype The object to inherit from.
         * @returns {Object} Returns the new object.
         */
        var baseCreate = (function() {
            function object() {}
            return function(prototype) {
                if (isObject(prototype)) {
                    object.prototype = prototype;
                    var result = new object;
                    object.prototype = undefined;
                }
                return result || {};
            };
        }());

        /**
         * The base implementation of `_.delay` and `_.defer` which accepts an array
         * of `func` arguments.
         *
         * @private
         * @param {Function} func The function to delay.
         * @param {number} wait The number of milliseconds to delay invocation.
         * @param {Object} args The arguments to provide to `func`.
         * @returns {number} Returns the timer id.
         */
        function baseDelay(func, wait, args) {
            if (typeof func != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            return setTimeout(function() { func.apply(undefined, args); }, wait);
        }

        /**
         * The base implementation of methods like `_.difference` without support for
         * excluding multiple arrays or iteratee shorthands.
         *
         * @private
         * @param {Array} array The array to inspect.
         * @param {Array} values The values to exclude.
         * @param {Function} [iteratee] The iteratee invoked per element.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new array of filtered values.
         */
        function baseDifference(array, values, iteratee, comparator) {
            var index = -1,
                includes = arrayIncludes,
                isCommon = true,
                length = array.length,
                result = [],
                valuesLength = values.length;

            if (!length) {
                return result;
            }
            if (iteratee) {
                values = arrayMap(values, baseUnary(iteratee));
            }
            if (comparator) {
                includes = arrayIncludesWith;
                isCommon = false;
            }
            else if (values.length >= LARGE_ARRAY_SIZE) {
                includes = cacheHas;
                isCommon = false;
                values = new SetCache(values);
            }
            outer:
                while (++index < length) {
                    var value = array[index],
                        computed = iteratee ? iteratee(value) : value;

                    if (isCommon && computed === computed) {
                        var valuesIndex = valuesLength;
                        while (valuesIndex--) {
                            if (values[valuesIndex] === computed) {
                                continue outer;
                            }
                        }
                        result.push(value);
                    }
                    else if (!includes(values, computed, comparator)) {
                        result.push(value);
                    }
                }
            return result;
        }

        /**
         * The base implementation of `_.forEach` without support for iteratee shorthands.
         *
         * @private
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} iteratee The function invoked per iteration.
         * @returns {Array|Object} Returns `collection`.
         */
        var baseEach = createBaseEach(baseForOwn);

        /**
         * The base implementation of `_.forEachRight` without support for iteratee shorthands.
         *
         * @private
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} iteratee The function invoked per iteration.
         * @returns {Array|Object} Returns `collection`.
         */
        var baseEachRight = createBaseEach(baseForOwnRight, true);

        /**
         * The base implementation of `_.every` without support for iteratee shorthands.
         *
         * @private
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} predicate The function invoked per iteration.
         * @returns {boolean} Returns `true` if all elements pass the predicate check, else `false`
         */
        function baseEvery(collection, predicate) {
            var result = true;
            baseEach(collection, function(value, index, collection) {
                result = !!predicate(value, index, collection);
                return result;
            });
            return result;
        }

        /**
         * The base implementation of `_.fill` without an iteratee call guard.
         *
         * @private
         * @param {Array} array The array to fill.
         * @param {*} value The value to fill `array` with.
         * @param {number} [start=0] The start position.
         * @param {number} [end=array.length] The end position.
         * @returns {Array} Returns `array`.
         */
        function baseFill(array, value, start, end) {
            var length = array.length;

            start = toInteger(start);
            if (start < 0) {
                start = -start > length ? 0 : (length + start);
            }
            end = (end === undefined || end > length) ? length : toInteger(end);
            if (end < 0) {
                end += length;
            }
            end = start > end ? 0 : toLength(end);
            while (start < end) {
                array[start++] = value;
            }
            return array;
        }

        /**
         * The base implementation of `_.filter` without support for iteratee shorthands.
         *
         * @private
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} predicate The function invoked per iteration.
         * @returns {Array} Returns the new filtered array.
         */
        function baseFilter(collection, predicate) {
            var result = [];
            baseEach(collection, function(value, index, collection) {
                if (predicate(value, index, collection)) {
                    result.push(value);
                }
            });
            return result;
        }

        /**
         * The base implementation of `_.flatten` with support for restricting flattening.
         *
         * @private
         * @param {Array} array The array to flatten.
         * @param {boolean} [isDeep] Specify a deep flatten.
         * @param {boolean} [isStrict] Restrict flattening to arrays-like objects.
         * @param {Array} [result=[]] The initial result value.
         * @returns {Array} Returns the new flattened array.
         */
        function baseFlatten(array, isDeep, isStrict, result) {
            result || (result = []);

            var index = -1,
                length = array.length;

            while (++index < length) {
                var value = array[index];
                if (isArrayLikeObject(value) &&
                    (isStrict || isArray(value) || isArguments(value))) {
                    if (isDeep) {
                        // Recursively flatten arrays (susceptible to call stack limits).
                        baseFlatten(value, isDeep, isStrict, result);
                    } else {
                        arrayPush(result, value);
                    }
                } else if (!isStrict) {
                    result[result.length] = value;
                }
            }
            return result;
        }

        /**
         * The base implementation of `baseForIn` and `baseForOwn` which iterates
         * over `object` properties returned by `keysFunc` invoking `iteratee` for
         * each property. Iteratee functions may exit iteration early by explicitly
         * returning `false`.
         *
         * @private
         * @param {Object} object The object to iterate over.
         * @param {Function} iteratee The function invoked per iteration.
         * @param {Function} keysFunc The function to get the keys of `object`.
         * @returns {Object} Returns `object`.
         */
        var baseFor = createBaseFor();

        /**
         * This function is like `baseFor` except that it iterates over properties
         * in the opposite order.
         *
         * @private
         * @param {Object} object The object to iterate over.
         * @param {Function} iteratee The function invoked per iteration.
         * @param {Function} keysFunc The function to get the keys of `object`.
         * @returns {Object} Returns `object`.
         */
        var baseForRight = createBaseFor(true);

        /**
         * The base implementation of `_.forIn` without support for iteratee shorthands.
         *
         * @private
         * @param {Object} object The object to iterate over.
         * @param {Function} iteratee The function invoked per iteration.
         * @returns {Object} Returns `object`.
         */
        function baseForIn(object, iteratee) {
            return object == null ? object : baseFor(object, iteratee, keysIn);
        }

        /**
         * The base implementation of `_.forOwn` without support for iteratee shorthands.
         *
         * @private
         * @param {Object} object The object to iterate over.
         * @param {Function} iteratee The function invoked per iteration.
         * @returns {Object} Returns `object`.
         */
        function baseForOwn(object, iteratee) {
            return object && baseFor(object, iteratee, keys);
        }

        /**
         * The base implementation of `_.forOwnRight` without support for iteratee shorthands.
         *
         * @private
         * @param {Object} object The object to iterate over.
         * @param {Function} iteratee The function invoked per iteration.
         * @returns {Object} Returns `object`.
         */
        function baseForOwnRight(object, iteratee) {
            return object && baseForRight(object, iteratee, keys);
        }

        /**
         * The base implementation of `_.functions` which creates an array of
         * `object` function property names filtered from `props`.
         *
         * @private
         * @param {Object} object The object to inspect.
         * @param {Array} props The property names to filter.
         * @returns {Array} Returns the new array of filtered property names.
         */
        function baseFunctions(object, props) {
            return arrayFilter(props, function(key) {
                return isFunction(object[key]);
            });
        }

        /**
         * The base implementation of `_.get` without support for default values.
         *
         * @private
         * @param {Object} object The object to query.
         * @param {Array|string} path The path of the property to get.
         * @returns {*} Returns the resolved value.
         */
        function baseGet(object, path) {
            path = isKey(path, object) ? [path + ''] : baseToPath(path);

            var index = 0,
                length = path.length;

            while (object != null && index < length) {
                object = object[path[index++]];
            }
            return (index && index == length) ? object : undefined;
        }

        /**
         * The base implementation of `_.has` without support for deep paths.
         *
         * @private
         * @param {Object} object The object to query.
         * @param {Array|string} key The key to check.
         * @returns {boolean} Returns `true` if `key` exists, else `false`.
         */
        function baseHas(object, key) {
            // Avoid a bug in IE 10-11 where objects with a [[Prototype]] of `null`,
            // that are composed entirely of index properties, return `false` for
            // `hasOwnProperty` checks of them.
            return hasOwnProperty.call(object, key) ||
                (typeof object == 'object' && key in object && getPrototypeOf(object) === null);
        }

        /**
         * The base implementation of `_.hasIn` without support for deep paths.
         *
         * @private
         * @param {Object} object The object to query.
         * @param {Array|string} key The key to check.
         * @returns {boolean} Returns `true` if `key` exists, else `false`.
         */
        function baseHasIn(object, key) {
            return key in Object(object);
        }

        /**
         * The base implementation of `_.inRange` which doesn't coerce arguments to numbers.
         *
         * @private
         * @param {number} number The number to check.
         * @param {number} start The start of the range.
         * @param {number} end The end of the range.
         * @returns {boolean} Returns `true` if `number` is in the range, else `false`.
         */
        function baseInRange(number, start, end) {
            return number >= nativeMin(start, end) && number < nativeMax(start, end);
        }

        /**
         * The base implementation of methods like `_.intersection`, without support
         * for iteratee shorthands, that accepts an array of arrays to inspect.
         *
         * @private
         * @param {Array} arrays The arrays to inspect.
         * @param {Function} [iteratee] The iteratee invoked per element.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new array of shared values.
         */
        function baseIntersection(arrays, iteratee, comparator) {
            var includes = comparator ? arrayIncludesWith : arrayIncludes,
                othLength = arrays.length,
                othIndex = othLength,
                caches = Array(othLength),
                result = [];

            while (othIndex--) {
                var array = arrays[othIndex];
                if (othIndex && iteratee) {
                    array = arrayMap(array, baseUnary(iteratee));
                }
                caches[othIndex] = !comparator && (iteratee || array.length >= 120)
                    ? new SetCache(othIndex && array)
                    : undefined;
            }
            array = arrays[0];

            var index = -1,
                length = array.length,
                seen = caches[0];

            outer:
                while (++index < length) {
                    var value = array[index],
                        computed = iteratee ? iteratee(value) : value;

                    if (!(seen ? cacheHas(seen, computed) : includes(result, computed, comparator))) {
                        var othIndex = othLength;
                        while (--othIndex) {
                            var cache = caches[othIndex];
                            if (!(cache ? cacheHas(cache, computed) : includes(arrays[othIndex], computed, comparator))) {
                                continue outer;
                            }
                        }
                        if (seen) {
                            seen.push(computed);
                        }
                        result.push(value);
                    }
                }
            return result;
        }

        /**
         * The base implementation of `_.invert` and `_.invertBy` which inverts
         * `object` with values transformed by `iteratee` and set by `setter`.
         *
         * @private
         * @param {Object} object The object to iterate over.
         * @param {Function} setter The function to set `accumulator` values.
         * @param {Function} iteratee The iteratee to transform values.
         * @param {Object} accumulator The initial inverted object.
         * @returns {Function} Returns `accumulator`.
         */
        function baseInverter(object, setter, iteratee, accumulator) {
            baseForOwn(object, function(value, key, object) {
                setter(accumulator, iteratee(value), key, object);
            });
            return accumulator;
        }

        /**
         * The base implementation of `_.invoke` without support for individual
         * method arguments.
         *
         * @private
         * @param {Object} object The object to query.
         * @param {Array|string} path The path of the method to invoke.
         * @param {Array} args The arguments to invoke the method with.
         * @returns {*} Returns the result of the invoked method.
         */
        function baseInvoke(object, path, args) {
            if (!isKey(path, object)) {
                path = baseToPath(path);
                object = parent(object, path);
                path = last(path);
            }
            var func = object == null ? object : object[path];
            return func == null ? undefined : apply(func, object, args);
        }

        /**
         * The base implementation of `_.isEqual` which supports partial comparisons
         * and tracks traversed objects.
         *
         * @private
         * @param {*} value The value to compare.
         * @param {*} other The other value to compare.
         * @param {Function} [customizer] The function to customize comparisons.
         * @param {boolean} [bitmask] The bitmask of comparison flags.
         *  The bitmask may be composed of the following flags:
         *     1 - Unordered comparison
         *     2 - Partial comparison
         * @param {Object} [stack] Tracks traversed `value` and `other` objects.
         * @returns {boolean} Returns `true` if the values are equivalent, else `false`.
         */
        function baseIsEqual(value, other, customizer, bitmask, stack) {
            if (value === other) {
                return true;
            }
            if (value == null || other == null || (!isObject(value) && !isObjectLike(other))) {
                return value !== value && other !== other;
            }
            return baseIsEqualDeep(value, other, baseIsEqual, customizer, bitmask, stack);
        }

        /**
         * A specialized version of `baseIsEqual` for arrays and objects which performs
         * deep comparisons and tracks traversed objects enabling objects with circular
         * references to be compared.
         *
         * @private
         * @param {Object} object The object to compare.
         * @param {Object} other The other object to compare.
         * @param {Function} equalFunc The function to determine equivalents of values.
         * @param {Function} [customizer] The function to customize comparisons.
         * @param {number} [bitmask] The bitmask of comparison flags. See `baseIsEqual` for more details.
         * @param {Object} [stack] Tracks traversed `object` and `other` objects.
         * @returns {boolean} Returns `true` if the objects are equivalent, else `false`.
         */
        function baseIsEqualDeep(object, other, equalFunc, customizer, bitmask, stack) {
            var objIsArr = isArray(object),
                othIsArr = isArray(other),
                objTag = arrayTag,
                othTag = arrayTag;

            if (!objIsArr) {
                objTag = getTag(object);
                if (objTag == argsTag) {
                    objTag = objectTag;
                } else if (objTag != objectTag) {
                    objIsArr = isTypedArray(object);
                }
            }
            if (!othIsArr) {
                othTag = getTag(other);
                if (othTag == argsTag) {
                    othTag = objectTag;
                } else if (othTag != objectTag) {
                    othIsArr = isTypedArray(other);
                }
            }
            var objIsObj = objTag == objectTag && !isHostObject(object),
                othIsObj = othTag == objectTag && !isHostObject(other),
                isSameTag = objTag == othTag;

            if (isSameTag && !(objIsArr || objIsObj)) {
                return equalByTag(object, other, objTag, equalFunc, customizer, bitmask);
            }
            var isPartial = bitmask & PARTIAL_COMPARE_FLAG;
            if (!isPartial) {
                var objIsWrapped = objIsObj && hasOwnProperty.call(object, '__wrapped__'),
                    othIsWrapped = othIsObj && hasOwnProperty.call(other, '__wrapped__');

                if (objIsWrapped || othIsWrapped) {
                    return equalFunc(objIsWrapped ? object.value() : object, othIsWrapped ? other.value() : other, customizer, bitmask, stack);
                }
            }
            if (!isSameTag) {
                return false;
            }
            stack || (stack = new Stack);
            return (objIsArr ? equalArrays : equalObjects)(object, other, equalFunc, customizer, bitmask, stack);
        }

        /**
         * The base implementation of `_.isMatch` without support for iteratee shorthands.
         *
         * @private
         * @param {Object} object The object to inspect.
         * @param {Object} source The object of property values to match.
         * @param {Array} matchData The property names, values, and compare flags to match.
         * @param {Function} [customizer] The function to customize comparisons.
         * @returns {boolean} Returns `true` if `object` is a match, else `false`.
         */
        function baseIsMatch(object, source, matchData, customizer) {
            var index = matchData.length,
                length = index,
                noCustomizer = !customizer;

            if (object == null) {
                return !length;
            }
            object = Object(object);
            while (index--) {
                var data = matchData[index];
                if ((noCustomizer && data[2])
                        ? data[1] !== object[data[0]]
                        : !(data[0] in object)
                ) {
                    return false;
                }
            }
            while (++index < length) {
                data = matchData[index];
                var key = data[0],
                    objValue = object[key],
                    srcValue = data[1];

                if (noCustomizer && data[2]) {
                    if (objValue === undefined && !(key in object)) {
                        return false;
                    }
                } else {
                    var stack = new Stack,
                        result = customizer ? customizer(objValue, srcValue, key, object, source, stack) : undefined;

                    if (!(result === undefined
                                ? baseIsEqual(srcValue, objValue, customizer, UNORDERED_COMPARE_FLAG | PARTIAL_COMPARE_FLAG, stack)
                                : result
                        )) {
                        return false;
                    }
                }
            }
            return true;
        }

        /**
         * The base implementation of `_.iteratee`.
         *
         * @private
         * @param {*} [value=_.identity] The value to convert to an iteratee.
         * @returns {Function} Returns the iteratee.
         */
        function baseIteratee(value) {
            var type = typeof value;
            if (type == 'function') {
                return value;
            }
            if (value == null) {
                return identity;
            }
            if (type == 'object') {
                return isArray(value)
                    ? baseMatchesProperty(value[0], value[1])
                    : baseMatches(value);
            }
            return property(value);
        }

        /**
         * The base implementation of `_.keys` which doesn't skip the constructor
         * property of prototypes or treat sparse arrays as dense.
         *
         * @private
         * @type Function
         * @param {Object} object The object to query.
         * @returns {Array} Returns the array of property names.
         */
        function baseKeys(object) {
            return nativeKeys(Object(object));
        }

        /**
         * The base implementation of `_.keysIn` which doesn't skip the constructor
         * property of prototypes or treat sparse arrays as dense.
         *
         * @private
         * @param {Object} object The object to query.
         * @returns {Array} Returns the array of property names.
         */
        function baseKeysIn(object) {
            object = object == null ? object : Object(object);

            var result = [];
            for (var key in object) {
                result.push(key);
            }
            return result;
        }

        // Fallback for IE < 9 with es6-shim.
        if (enumerate && !propertyIsEnumerable.call({ 'valueOf': 1 }, 'valueOf')) {
            baseKeysIn = function(object) {
                return iteratorToArray(enumerate(object));
            };
        }

        /**
         * The base implementation of `_.map` without support for iteratee shorthands.
         *
         * @private
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} iteratee The function invoked per iteration.
         * @returns {Array} Returns the new mapped array.
         */
        function baseMap(collection, iteratee) {
            var index = -1,
                result = isArrayLike(collection) ? Array(collection.length) : [];

            baseEach(collection, function(value, key, collection) {
                result[++index] = iteratee(value, key, collection);
            });
            return result;
        }

        /**
         * The base implementation of `_.matches` which doesn't clone `source`.
         *
         * @private
         * @param {Object} source The object of property values to match.
         * @returns {Function} Returns the new function.
         */
        function baseMatches(source) {
            var matchData = getMatchData(source);
            if (matchData.length == 1 && matchData[0][2]) {
                var key = matchData[0][0],
                    value = matchData[0][1];

                return function(object) {
                    if (object == null) {
                        return false;
                    }
                    return object[key] === value &&
                        (value !== undefined || (key in Object(object)));
                };
            }
            return function(object) {
                return object === source || baseIsMatch(object, source, matchData);
            };
        }

        /**
         * The base implementation of `_.matchesProperty` which doesn't clone `srcValue`.
         *
         * @private
         * @param {string} path The path of the property to get.
         * @param {*} srcValue The value to match.
         * @returns {Function} Returns the new function.
         */
        function baseMatchesProperty(path, srcValue) {
            return function(object) {
                var objValue = get(object, path);
                return (objValue === undefined && objValue === srcValue)
                    ? hasIn(object, path)
                    : baseIsEqual(srcValue, objValue, undefined, UNORDERED_COMPARE_FLAG | PARTIAL_COMPARE_FLAG);
            };
        }

        /**
         * The base implementation of `_.merge` without support for multiple sources.
         *
         * @private
         * @param {Object} object The destination object.
         * @param {Object} source The source object.
         * @param {number} srcIndex The index of `source`.
         * @param {Function} [customizer] The function to customize merged values.
         * @param {Object} [stack] Tracks traversed source values and their merged counterparts.
         */
        function baseMerge(object, source, srcIndex, customizer, stack) {
            if (object === source) {
                return;
            }
            var props = (isArray(source) || isTypedArray(source)) ? undefined : keysIn(source);
            arrayEach(props || source, function(srcValue, key) {
                if (props) {
                    key = srcValue;
                    srcValue = source[key];
                }
                if (isObject(srcValue)) {
                    stack || (stack = new Stack);
                    baseMergeDeep(object, source, key, srcIndex, baseMerge, customizer, stack);
                }
                else {
                    var newValue = customizer ? customizer(object[key], srcValue, (key + ''), object, source, stack) : undefined;
                    if (newValue === undefined) {
                        newValue = srcValue;
                    }
                    assignMergeValue(object, key, newValue);
                }
            });
        }

        /**
         * A specialized version of `baseMerge` for arrays and objects which performs
         * deep merges and tracks traversed objects enabling objects with circular
         * references to be merged.
         *
         * @private
         * @param {Object} object The destination object.
         * @param {Object} source The source object.
         * @param {string} key The key of the value to merge.
         * @param {number} srcIndex The index of `source`.
         * @param {Function} mergeFunc The function to merge values.
         * @param {Function} [customizer] The function to customize assigned values.
         * @param {Object} [stack] Tracks traversed source values and their merged counterparts.
         */
        function baseMergeDeep(object, source, key, srcIndex, mergeFunc, customizer, stack) {
            var objValue = object[key],
                srcValue = source[key],
                stacked = stack.get(srcValue);

            if (stacked) {
                assignMergeValue(object, key, stacked);
                return;
            }
            var newValue = customizer ? customizer(objValue, srcValue, (key + ''), object, source, stack) : undefined,
                isCommon = newValue === undefined;

            if (isCommon) {
                newValue = srcValue;
                if (isArray(srcValue) || isTypedArray(srcValue)) {
                    if (isArray(objValue)) {
                        newValue = srcIndex ? copyArray(objValue) : objValue;
                    }
                    else if (isArrayLikeObject(objValue)) {
                        newValue = copyArray(objValue);
                    }
                    else {
                        isCommon = false;
                        newValue = baseClone(srcValue);
                    }
                }
                else if (isPlainObject(srcValue) || isArguments(srcValue)) {
                    if (isArguments(objValue)) {
                        newValue = toPlainObject(objValue);
                    }
                    else if (!isObject(objValue) || (srcIndex && isFunction(objValue))) {
                        isCommon = false;
                        newValue = baseClone(srcValue);
                    }
                    else {
                        newValue = srcIndex ? baseClone(objValue) : objValue;
                    }
                }
                else {
                    isCommon = false;
                }
            }
            stack.set(srcValue, newValue);

            if (isCommon) {
                // Recursively merge objects and arrays (susceptible to call stack limits).
                mergeFunc(newValue, srcValue, srcIndex, customizer, stack);
            }
            assignMergeValue(object, key, newValue);
        }

        /**
         * The base implementation of `_.orderBy` without param guards.
         *
         * @private
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function[]|Object[]|string[]} iteratees The iteratees to sort by.
         * @param {string[]} orders The sort orders of `iteratees`.
         * @returns {Array} Returns the new sorted array.
         */
        function baseOrderBy(collection, iteratees, orders) {
            var index = -1,
                toIteratee = getIteratee();

            iteratees = arrayMap(iteratees.length ? iteratees : Array(1), function(iteratee) {
                return toIteratee(iteratee);
            });

            var result = baseMap(collection, function(value, key, collection) {
                var criteria = arrayMap(iteratees, function(iteratee) {
                    return iteratee(value);
                });
                return { 'criteria': criteria, 'index': ++index, 'value': value };
            });

            return baseSortBy(result, function(object, other) {
                return compareMultiple(object, other, orders);
            });
        }

        /**
         * The base implementation of `_.pick` without support for individual
         * property names.
         *
         * @private
         * @param {Object} object The source object.
         * @param {string[]} props The property names to pick.
         * @returns {Object} Returns the new object.
         */
        function basePick(object, props) {
            object = Object(object);
            return arrayReduce(props, function(result, key) {
                if (key in object) {
                    result[key] = object[key];
                }
                return result;
            }, {});
        }

        /**
         * The base implementation of  `_.pickBy` without support for iteratee shorthands.
         *
         * @private
         * @param {Object} object The source object.
         * @param {Function} predicate The function invoked per property.
         * @returns {Object} Returns the new object.
         */
        function basePickBy(object, predicate) {
            var result = {};
            baseForIn(object, function(value, key) {
                if (predicate(value, key)) {
                    result[key] = value;
                }
            });
            return result;
        }

        /**
         * The base implementation of `_.property` without support for deep paths.
         *
         * @private
         * @param {string} key The key of the property to get.
         * @returns {Function} Returns the new function.
         */
        function baseProperty(key) {
            return function(object) {
                return object == null ? undefined : object[key];
            };
        }

        /**
         * A specialized version of `baseProperty` which supports deep paths.
         *
         * @private
         * @param {Array|string} path The path of the property to get.
         * @returns {Function} Returns the new function.
         */
        function basePropertyDeep(path) {
            return function(object) {
                return baseGet(object, path);
            };
        }

        /**
         * The base implementation of `_.pullAll`.
         *
         * @private
         * @param {Array} array The array to modify.
         * @param {Array} values The values to remove.
         * @returns {Array} Returns `array`.
         */
        function basePullAll(array, values) {
            return basePullAllBy(array, values);
        }

        /**
         * The base implementation of `_.pullAllBy` without support for iteratee
         * shorthands.
         *
         * @private
         * @param {Array} array The array to modify.
         * @param {Array} values The values to remove.
         * @param {Function} [iteratee] The iteratee invoked per element.
         * @returns {Array} Returns `array`.
         */
        function basePullAllBy(array, values, iteratee) {
            var index = -1,
                length = values.length,
                seen = array;

            if (iteratee) {
                seen = arrayMap(array, function(value) { return iteratee(value); });
            }
            while (++index < length) {
                var fromIndex = 0,
                    value = values[index],
                    computed = iteratee ? iteratee(value) : value;

                while ((fromIndex = baseIndexOf(seen, computed, fromIndex)) > -1) {
                    if (seen !== array) {
                        splice.call(seen, fromIndex, 1);
                    }
                    splice.call(array, fromIndex, 1);
                }
            }
            return array;
        }

        /**
         * The base implementation of `_.pullAt` without support for individual
         * indexes or capturing the removed elements.
         *
         * @private
         * @param {Array} array The array to modify.
         * @param {number[]} indexes The indexes of elements to remove.
         * @returns {Array} Returns `array`.
         */
        function basePullAt(array, indexes) {
            var length = array ? indexes.length : 0,
                lastIndex = length - 1;

            while (length--) {
                var index = indexes[length];
                if (lastIndex == length || index != previous) {
                    var previous = index;
                    if (isIndex(index)) {
                        splice.call(array, index, 1);
                    }
                    else if (!isKey(index, array)) {
                        var path = baseToPath(index),
                            object = parent(array, path);

                        if (object != null) {
                            delete object[last(path)];
                        }
                    }
                    else {
                        delete array[index];
                    }
                }
            }
            return array;
        }

        /**
         * The base implementation of `_.random` without support for returning
         * floating-point numbers.
         *
         * @private
         * @param {number} lower The lower bound.
         * @param {number} upper The upper bound.
         * @returns {number} Returns the random number.
         */
        function baseRandom(lower, upper) {
            return lower + nativeFloor(nativeRandom() * (upper - lower + 1));
        }

        /**
         * The base implementation of `_.range` and `_.rangeRight` which doesn't
         * coerce arguments to numbers.
         *
         * @private
         * @param {number} start The start of the range.
         * @param {number} end The end of the range.
         * @param {number} step The value to increment or decrement by.
         * @param {boolean} [fromRight] Specify iterating from right to left.
         * @returns {Array} Returns the new array of numbers.
         */
        function baseRange(start, end, step, fromRight) {
            var index = -1,
                length = nativeMax(nativeCeil((end - start) / (step || 1)), 0),
                result = Array(length);

            while (length--) {
                result[fromRight ? length : ++index] = start;
                start += step;
            }
            return result;
        }

        /**
         * The base implementation of `_.set`.
         *
         * @private
         * @param {Object} object The object to query.
         * @param {Array|string} path The path of the property to set.
         * @param {*} value The value to set.
         * @param {Function} [customizer] The function to customize path creation.
         * @returns {Object} Returns `object`.
         */
        function baseSet(object, path, value, customizer) {
            path = isKey(path, object) ? [path + ''] : baseToPath(path);

            var index = -1,
                length = path.length,
                lastIndex = length - 1,
                nested = object;

            while (nested != null && ++index < length) {
                var key = path[index];
                if (isObject(nested)) {
                    var newValue = value;
                    if (index != lastIndex) {
                        var objValue = nested[key];
                        newValue = customizer ? customizer(objValue, key, nested) : undefined;
                        if (newValue === undefined) {
                            newValue = objValue == null ? (isIndex(path[index + 1]) ? [] : {}) : objValue;
                        }
                    }
                    assignValue(nested, key, newValue);
                }
                nested = nested[key];
            }
            return object;
        }

        /**
         * The base implementation of `setData` without support for hot loop detection.
         *
         * @private
         * @param {Function} func The function to associate metadata with.
         * @param {*} data The metadata.
         * @returns {Function} Returns `func`.
         */
        var baseSetData = !metaMap ? identity : function(func, data) {
            metaMap.set(func, data);
            return func;
        };

        /**
         * The base implementation of `_.slice` without an iteratee call guard.
         *
         * @private
         * @param {Array} array The array to slice.
         * @param {number} [start=0] The start position.
         * @param {number} [end=array.length] The end position.
         * @returns {Array} Returns the slice of `array`.
         */
        function baseSlice(array, start, end) {
            var index = -1,
                length = array.length;

            if (start < 0) {
                start = -start > length ? 0 : (length + start);
            }
            end = end > length ? length : end;
            if (end < 0) {
                end += length;
            }
            length = start > end ? 0 : ((end - start) >>> 0);
            start >>>= 0;

            var result = Array(length);
            while (++index < length) {
                result[index] = array[index + start];
            }
            return result;
        }

        /**
         * The base implementation of `_.some` without support for iteratee shorthands.
         *
         * @private
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} predicate The function invoked per iteration.
         * @returns {boolean} Returns `true` if any element passes the predicate check, else `false`.
         */
        function baseSome(collection, predicate) {
            var result;

            baseEach(collection, function(value, index, collection) {
                result = predicate(value, index, collection);
                return !result;
            });
            return !!result;
        }

        /**
         * The base implementation of `_.sortedIndex` and `_.sortedLastIndex` which
         * performs a binary search of `array` to determine the index at which `value`
         * should be inserted into `array` in order to maintain its sort order.
         *
         * @private
         * @param {Array} array The sorted array to inspect.
         * @param {*} value The value to evaluate.
         * @param {boolean} [retHighest] Specify returning the highest qualified index.
         * @returns {number} Returns the index at which `value` should be inserted
         *  into `array`.
         */
        function baseSortedIndex(array, value, retHighest) {
            var low = 0,
                high = array ? array.length : low;

            if (typeof value == 'number' && value === value && high <= HALF_MAX_ARRAY_LENGTH) {
                while (low < high) {
                    var mid = (low + high) >>> 1,
                        computed = array[mid];

                    if ((retHighest ? (computed <= value) : (computed < value)) && computed !== null) {
                        low = mid + 1;
                    } else {
                        high = mid;
                    }
                }
                return high;
            }
            return baseSortedIndexBy(array, value, identity, retHighest);
        }

        /**
         * The base implementation of `_.sortedIndexBy` and `_.sortedLastIndexBy`
         * which invokes `iteratee` for `value` and each element of `array` to compute
         * their sort ranking. The iteratee is invoked with one argument; (value).
         *
         * @private
         * @param {Array} array The sorted array to inspect.
         * @param {*} value The value to evaluate.
         * @param {Function} iteratee The iteratee invoked per element.
         * @param {boolean} [retHighest] Specify returning the highest qualified index.
         * @returns {number} Returns the index at which `value` should be inserted into `array`.
         */
        function baseSortedIndexBy(array, value, iteratee, retHighest) {
            value = iteratee(value);

            var low = 0,
                high = array ? array.length : 0,
                valIsNaN = value !== value,
                valIsNull = value === null,
                valIsUndef = value === undefined;

            while (low < high) {
                var mid = nativeFloor((low + high) / 2),
                    computed = iteratee(array[mid]),
                    isDef = computed !== undefined,
                    isReflexive = computed === computed;

                if (valIsNaN) {
                    var setLow = isReflexive || retHighest;
                } else if (valIsNull) {
                    setLow = isReflexive && isDef && (retHighest || computed != null);
                } else if (valIsUndef) {
                    setLow = isReflexive && (retHighest || isDef);
                } else if (computed == null) {
                    setLow = false;
                } else {
                    setLow = retHighest ? (computed <= value) : (computed < value);
                }
                if (setLow) {
                    low = mid + 1;
                } else {
                    high = mid;
                }
            }
            return nativeMin(high, MAX_ARRAY_INDEX);
        }

        /**
         * The base implementation of `_.sortedUniq`.
         *
         * @private
         * @param {Array} array The array to inspect.
         * @returns {Array} Returns the new duplicate free array.
         */
        function baseSortedUniq(array) {
            return baseSortedUniqBy(array);
        }

        /**
         * The base implementation of `_.sortedUniqBy` without support for iteratee
         * shorthands.
         *
         * @private
         * @param {Array} array The array to inspect.
         * @param {Function} [iteratee] The iteratee invoked per element.
         * @returns {Array} Returns the new duplicate free array.
         */
        function baseSortedUniqBy(array, iteratee) {
            var index = 0,
                length = array.length,
                value = array[0],
                computed = iteratee ? iteratee(value) : value,
                seen = computed,
                resIndex = 0,
                result = [value];

            while (++index < length) {
                value = array[index],
                    computed = iteratee ? iteratee(value) : value;

                if (!eq(computed, seen)) {
                    seen = computed;
                    result[++resIndex] = value;
                }
            }
            return result;
        }

        /**
         * The base implementation of `_.toPath` which only converts `value` to a
         * path if it's not one.
         *
         * @private
         * @param {*} value The value to process.
         * @returns {Array} Returns the property path array.
         */
        function baseToPath(value) {
            return isArray(value) ? value : stringToPath(value);
        }

        /**
         * The base implementation of `_.uniqBy` without support for iteratee shorthands.
         *
         * @private
         * @param {Array} array The array to inspect.
         * @param {Function} [iteratee] The iteratee invoked per element.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new duplicate free array.
         */
        function baseUniq(array, iteratee, comparator) {
            var index = -1,
                includes = arrayIncludes,
                length = array.length,
                isCommon = true,
                result = [],
                seen = result;

            if (comparator) {
                isCommon = false;
                includes = arrayIncludesWith;
            }
            else if (length >= LARGE_ARRAY_SIZE) {
                var set = iteratee ? null : createSet(array);
                if (set) {
                    return setToArray(set);
                }
                isCommon = false;
                includes = cacheHas;
                seen = new SetCache;
            }
            else {
                seen = iteratee ? [] : result;
            }
            outer:
                while (++index < length) {
                    var value = array[index],
                        computed = iteratee ? iteratee(value) : value;

                    if (isCommon && computed === computed) {
                        var seenIndex = seen.length;
                        while (seenIndex--) {
                            if (seen[seenIndex] === computed) {
                                continue outer;
                            }
                        }
                        if (iteratee) {
                            seen.push(computed);
                        }
                        result.push(value);
                    }
                    else if (!includes(seen, computed, comparator)) {
                        if (seen !== result) {
                            seen.push(computed);
                        }
                        result.push(value);
                    }
                }
            return result;
        }

        /**
         * The base implementation of `_.unset`.
         *
         * @private
         * @param {Object} object The object to modify.
         * @param {Array|string} path The path of the property to unset.
         * @returns {boolean} Returns `true` if the property is deleted, else `false`.
         */
        function baseUnset(object, path) {
            path = isKey(path, object) ? [path + ''] : baseToPath(path);
            object = parent(object, path);
            var key = last(path);
            return (object != null && has(object, key)) ? delete object[key] : true;
        }

        /**
         * The base implementation of methods like `_.dropWhile` and `_.takeWhile`
         * without support for iteratee shorthands.
         *
         * @private
         * @param {Array} array The array to query.
         * @param {Function} predicate The function invoked per iteration.
         * @param {boolean} [isDrop] Specify dropping elements instead of taking them.
         * @param {boolean} [fromRight] Specify iterating from right to left.
         * @returns {Array} Returns the slice of `array`.
         */
        function baseWhile(array, predicate, isDrop, fromRight) {
            var length = array.length,
                index = fromRight ? length : -1;

            while ((fromRight ? index-- : ++index < length) &&
            predicate(array[index], index, array)) {}

            return isDrop
                ? baseSlice(array, (fromRight ? 0 : index), (fromRight ? index + 1 : length))
                : baseSlice(array, (fromRight ? index + 1 : 0), (fromRight ? length : index));
        }

        /**
         * The base implementation of `wrapperValue` which returns the result of
         * performing a sequence of actions on the unwrapped `value`, where each
         * successive action is supplied the return value of the previous.
         *
         * @private
         * @param {*} value The unwrapped value.
         * @param {Array} actions Actions to perform to resolve the unwrapped value.
         * @returns {*} Returns the resolved value.
         */
        function baseWrapperValue(value, actions) {
            var result = value;
            if (result instanceof LazyWrapper) {
                result = result.value();
            }
            return arrayReduce(actions, function(result, action) {
                return action.func.apply(action.thisArg, arrayPush([result], action.args));
            }, result);
        }

        /**
         * The base implementation of methods like `_.xor`, without support for
         * iteratee shorthands, that accepts an array of arrays to inspect.
         *
         * @private
         * @param {Array} arrays The arrays to inspect.
         * @param {Function} [iteratee] The iteratee invoked per element.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new array of values.
         */
        function baseXor(arrays, iteratee, comparator) {
            var index = -1,
                length = arrays.length;

            while (++index < length) {
                var result = result
                    ? arrayPush(
                    baseDifference(result, arrays[index], iteratee, comparator),
                    baseDifference(arrays[index], result, iteratee, comparator)
                )
                    : arrays[index];
            }
            return (result && result.length) ? baseUniq(result, iteratee, comparator) : [];
        }

        /**
         * This base implementation of `_.zipObject` which assigns values using `assignFunc`.
         *
         * @private
         * @param {Array} props The property names.
         * @param {Array} values The property values.
         * @param {Function} assignFunc The function to assign values.
         * @returns {Object} Returns the new object.
         */
        function baseZipObject(props, values, assignFunc) {
            var index = -1,
                length = props.length,
                valsLength = values.length,
                result = {};

            while (++index < length) {
                assignFunc(result, props[index], index < valsLength ? values[index] : undefined);
            }
            return result;
        }

        /**
         * Creates a clone of  `buffer`.
         *
         * @private
         * @param {Buffer} buffer The buffer to clone.
         * @param {boolean} [isDeep] Specify a deep clone.
         * @returns {Buffer} Returns the cloned buffer.
         */
        function cloneBuffer(buffer, isDeep) {
            if (isDeep) {
                return buffer.slice();
            }
            var Ctor = buffer.constructor,
                result = new Ctor(buffer.length);

            buffer.copy(result);
            return result;
        }

        /**
         * Creates a clone of `arrayBuffer`.
         *
         * @private
         * @param {ArrayBuffer} arrayBuffer The array buffer to clone.
         * @returns {ArrayBuffer} Returns the cloned array buffer.
         */
        function cloneArrayBuffer(arrayBuffer) {
            var Ctor = arrayBuffer.constructor,
                result = new Ctor(arrayBuffer.byteLength),
                view = new Uint8Array(result);

            view.set(new Uint8Array(arrayBuffer));
            return result;
        }

        /**
         * Creates a clone of `map`.
         *
         * @private
         * @param {Object} map The map to clone.
         * @returns {Object} Returns the cloned map.
         */
        function cloneMap(map) {
            var Ctor = map.constructor;
            return arrayReduce(mapToArray(map), addMapEntry, new Ctor);
        }

        /**
         * Creates a clone of `regexp`.
         *
         * @private
         * @param {Object} regexp The regexp to clone.
         * @returns {Object} Returns the cloned regexp.
         */
        function cloneRegExp(regexp) {
            var Ctor = regexp.constructor,
                result = new Ctor(regexp.source, reFlags.exec(regexp));

            result.lastIndex = regexp.lastIndex;
            return result;
        }

        /**
         * Creates a clone of `set`.
         *
         * @private
         * @param {Object} set The set to clone.
         * @returns {Object} Returns the cloned set.
         */
        function cloneSet(set) {
            var Ctor = set.constructor;
            return arrayReduce(setToArray(set), addSetEntry, new Ctor);
        }

        /**
         * Creates a clone of the `symbol` object.
         *
         * @private
         * @param {Object} symbol The symbol object to clone.
         * @returns {Object} Returns the cloned symbol object.
         */
        function cloneSymbol(symbol) {
            return Symbol ? Object(symbolValueOf.call(symbol)) : {};
        }

        /**
         * Creates a clone of `typedArray`.
         *
         * @private
         * @param {Object} typedArray The typed array to clone.
         * @param {boolean} [isDeep] Specify a deep clone.
         * @returns {Object} Returns the cloned typed array.
         */
        function cloneTypedArray(typedArray, isDeep) {
            var buffer = typedArray.buffer,
                Ctor = typedArray.constructor;

            return new Ctor(isDeep ? cloneArrayBuffer(buffer) : buffer, typedArray.byteOffset, typedArray.length);
        }

        /**
         * Creates an array that is the composition of partially applied arguments,
         * placeholders, and provided arguments into a single array of arguments.
         *
         * @private
         * @param {Array|Object} args The provided arguments.
         * @param {Array} partials The arguments to prepend to those provided.
         * @param {Array} holders The `partials` placeholder indexes.
         * @returns {Array} Returns the new array of composed arguments.
         */
        function composeArgs(args, partials, holders) {
            var holdersLength = holders.length,
                argsIndex = -1,
                argsLength = nativeMax(args.length - holdersLength, 0),
                leftIndex = -1,
                leftLength = partials.length,
                result = Array(leftLength + argsLength);

            while (++leftIndex < leftLength) {
                result[leftIndex] = partials[leftIndex];
            }
            while (++argsIndex < holdersLength) {
                result[holders[argsIndex]] = args[argsIndex];
            }
            while (argsLength--) {
                result[leftIndex++] = args[argsIndex++];
            }
            return result;
        }

        /**
         * This function is like `composeArgs` except that the arguments composition
         * is tailored for `_.partialRight`.
         *
         * @private
         * @param {Array|Object} args The provided arguments.
         * @param {Array} partials The arguments to append to those provided.
         * @param {Array} holders The `partials` placeholder indexes.
         * @returns {Array} Returns the new array of composed arguments.
         */
        function composeArgsRight(args, partials, holders) {
            var holdersIndex = -1,
                holdersLength = holders.length,
                argsIndex = -1,
                argsLength = nativeMax(args.length - holdersLength, 0),
                rightIndex = -1,
                rightLength = partials.length,
                result = Array(argsLength + rightLength);

            while (++argsIndex < argsLength) {
                result[argsIndex] = args[argsIndex];
            }
            var offset = argsIndex;
            while (++rightIndex < rightLength) {
                result[offset + rightIndex] = partials[rightIndex];
            }
            while (++holdersIndex < holdersLength) {
                result[offset + holders[holdersIndex]] = args[argsIndex++];
            }
            return result;
        }

        /**
         * Copies the values of `source` to `array`.
         *
         * @private
         * @param {Array} source The array to copy values from.
         * @param {Array} [array=[]] The array to copy values to.
         * @returns {Array} Returns `array`.
         */
        function copyArray(source, array) {
            var index = -1,
                length = source.length;

            array || (array = Array(length));
            while (++index < length) {
                array[index] = source[index];
            }
            return array;
        }

        /**
         * Copies properties of `source` to `object`.
         *
         * @private
         * @param {Object} source The object to copy properties from.
         * @param {Array} props The property names to copy.
         * @param {Object} [object={}] The object to copy properties to.
         * @returns {Object} Returns `object`.
         */
        function copyObject(source, props, object) {
            return copyObjectWith(source, props, object);
        }

        /**
         * This function is like `copyObject` except that it accepts a function to
         * customize copied values.
         *
         * @private
         * @param {Object} source The object to copy properties from.
         * @param {Array} props The property names to copy.
         * @param {Object} [object={}] The object to copy properties to.
         * @param {Function} [customizer] The function to customize copied values.
         * @returns {Object} Returns `object`.
         */
        function copyObjectWith(source, props, object, customizer) {
            object || (object = {});

            var index = -1,
                length = props.length;

            while (++index < length) {
                var key = props[index],
                    newValue = customizer ? customizer(object[key], source[key], key, object, source) : source[key];

                assignValue(object, key, newValue);
            }
            return object;
        }

        /**
         * Copies own symbol properties of `source` to `object`.
         *
         * @private
         * @param {Object} source The object to copy symbols from.
         * @param {Object} [object={}] The object to copy symbols to.
         * @returns {Object} Returns `object`.
         */
        function copySymbols(source, object) {
            return copyObject(source, getSymbols(source), object);
        }

        /**
         * Creates a function like `_.groupBy`.
         *
         * @private
         * @param {Function} setter The function to set accumulator values.
         * @param {Function} [initializer] The accumulator object initializer.
         * @returns {Function} Returns the new aggregator function.
         */
        function createAggregator(setter, initializer) {
            return function(collection, iteratee) {
                var func = isArray(collection) ? arrayAggregator : baseAggregator,
                    accumulator = initializer ? initializer() : {};

                return func(collection, setter, getIteratee(iteratee), accumulator);
            };
        }

        /**
         * Creates a function like `_.assign`.
         *
         * @private
         * @param {Function} assigner The function to assign values.
         * @returns {Function} Returns the new assigner function.
         */
        function createAssigner(assigner) {
            return rest(function(object, sources) {
                var index = -1,
                    length = sources.length,
                    customizer = length > 1 ? sources[length - 1] : undefined,
                    guard = length > 2 ? sources[2] : undefined;

                customizer = typeof customizer == 'function' ? (length--, customizer) : undefined;
                if (guard && isIterateeCall(sources[0], sources[1], guard)) {
                    customizer = length < 3 ? undefined : customizer;
                    length = 1;
                }
                object = Object(object);
                while (++index < length) {
                    var source = sources[index];
                    if (source) {
                        assigner(object, source, index, customizer);
                    }
                }
                return object;
            });
        }

        /**
         * Creates a `baseEach` or `baseEachRight` function.
         *
         * @private
         * @param {Function} eachFunc The function to iterate over a collection.
         * @param {boolean} [fromRight] Specify iterating from right to left.
         * @returns {Function} Returns the new base function.
         */
        function createBaseEach(eachFunc, fromRight) {
            return function(collection, iteratee) {
                if (collection == null) {
                    return collection;
                }
                if (!isArrayLike(collection)) {
                    return eachFunc(collection, iteratee);
                }
                var length = collection.length,
                    index = fromRight ? length : -1,
                    iterable = Object(collection);

                while ((fromRight ? index-- : ++index < length)) {
                    if (iteratee(iterable[index], index, iterable) === false) {
                        break;
                    }
                }
                return collection;
            };
        }

        /**
         * Creates a base function for methods like `_.forIn`.
         *
         * @private
         * @param {boolean} [fromRight] Specify iterating from right to left.
         * @returns {Function} Returns the new base function.
         */
        function createBaseFor(fromRight) {
            return function(object, iteratee, keysFunc) {
                var index = -1,
                    iterable = Object(object),
                    props = keysFunc(object),
                    length = props.length;

                while (length--) {
                    var key = props[fromRight ? length : ++index];
                    if (iteratee(iterable[key], key, iterable) === false) {
                        break;
                    }
                }
                return object;
            };
        }

        /**
         * Creates a function that wraps `func` to invoke it with the optional `this`
         * binding of `thisArg`.
         *
         * @private
         * @param {Function} func The function to wrap.
         * @param {number} bitmask The bitmask of wrapper flags. See `createWrapper` for more details.
         * @param {*} [thisArg] The `this` binding of `func`.
         * @returns {Function} Returns the new wrapped function.
         */
        function createBaseWrapper(func, bitmask, thisArg) {
            var isBind = bitmask & BIND_FLAG,
                Ctor = createCtorWrapper(func);

            function wrapper() {
                var fn = (this && this !== root && this instanceof wrapper) ? Ctor : func;
                return fn.apply(isBind ? thisArg : this, arguments);
            }
            return wrapper;
        }

        /**
         * Creates a function like `_.lowerFirst`.
         *
         * @private
         * @param {string} methodName The name of the `String` case method to use.
         * @returns {Function} Returns the new function.
         */
        function createCaseFirst(methodName) {
            return function(string) {
                string = toString(string);

                var strSymbols = reHasComplexSymbol.test(string) ? stringToArray(string) : undefined,
                    chr = strSymbols ? strSymbols[0] : string.charAt(0),
                    trailing = strSymbols ? strSymbols.slice(1).join('') : string.slice(1);

                return chr[methodName]() + trailing;
            };
        }

        /**
         * Creates a function like `_.camelCase`.
         *
         * @private
         * @param {Function} callback The function to combine each word.
         * @returns {Function} Returns the new compounder function.
         */
        function createCompounder(callback) {
            return function(string) {
                return arrayReduce(words(deburr(string)), callback, '');
            };
        }

        /**
         * Creates a function that produces an instance of `Ctor` regardless of
         * whether it was invoked as part of a `new` expression or by `call` or `apply`.
         *
         * @private
         * @param {Function} Ctor The constructor to wrap.
         * @returns {Function} Returns the new wrapped function.
         */
        function createCtorWrapper(Ctor) {
            return function() {
                // Use a `switch` statement to work with class constructors.
                // See http://ecma-international.org/ecma-262/6.0/#sec-ecmascript-function-objects-call-thisargument-argumentslist
                // for more details.
                var args = arguments;
                switch (args.length) {
                    case 0: return new Ctor;
                    case 1: return new Ctor(args[0]);
                    case 2: return new Ctor(args[0], args[1]);
                    case 3: return new Ctor(args[0], args[1], args[2]);
                    case 4: return new Ctor(args[0], args[1], args[2], args[3]);
                    case 5: return new Ctor(args[0], args[1], args[2], args[3], args[4]);
                    case 6: return new Ctor(args[0], args[1], args[2], args[3], args[4], args[5]);
                    case 7: return new Ctor(args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
                }
                var thisBinding = baseCreate(Ctor.prototype),
                    result = Ctor.apply(thisBinding, args);

                // Mimic the constructor's `return` behavior.
                // See https://es5.github.io/#x13.2.2 for more details.
                return isObject(result) ? result : thisBinding;
            };
        }

        /**
         * Creates a function that wraps `func` to enable currying.
         *
         * @private
         * @param {Function} func The function to wrap.
         * @param {number} bitmask The bitmask of wrapper flags. See `createWrapper` for more details.
         * @param {number} arity The arity of `func`.
         * @returns {Function} Returns the new wrapped function.
         */
        function createCurryWrapper(func, bitmask, arity) {
            var Ctor = createCtorWrapper(func);

            function wrapper() {
                var length = arguments.length,
                    index = length,
                    args = Array(length),
                    fn = (this && this !== root && this instanceof wrapper) ? Ctor : func,
                    placeholder = lodash.placeholder || wrapper.placeholder;

                while (index--) {
                    args[index] = arguments[index];
                }
                var holders = (length < 3 && args[0] !== placeholder && args[length - 1] !== placeholder)
                    ? []
                    : replaceHolders(args, placeholder);

                length -= holders.length;
                return length < arity
                    ? createRecurryWrapper(func, bitmask, createHybridWrapper, placeholder, undefined, args, holders, undefined, undefined, arity - length)
                    : apply(fn, this, args);
            }
            return wrapper;
        }

        /**
         * Creates a `_.flow` or `_.flowRight` function.
         *
         * @private
         * @param {boolean} [fromRight] Specify iterating from right to left.
         * @returns {Function} Returns the new flow function.
         */
        function createFlow(fromRight) {
            return rest(function(funcs) {
                funcs = baseFlatten(funcs);

                var length = funcs.length,
                    index = length,
                    prereq = LodashWrapper.prototype.thru;

                if (fromRight) {
                    funcs.reverse();
                }
                while (index--) {
                    var func = funcs[index];
                    if (typeof func != 'function') {
                        throw new TypeError(FUNC_ERROR_TEXT);
                    }
                    if (prereq && !wrapper && getFuncName(func) == 'wrapper') {
                        var wrapper = new LodashWrapper([], true);
                    }
                }
                index = wrapper ? index : length;
                while (++index < length) {
                    func = funcs[index];

                    var funcName = getFuncName(func),
                        data = funcName == 'wrapper' ? getData(func) : undefined;

                    if (data && isLaziable(data[0]) && data[1] == (ARY_FLAG | CURRY_FLAG | PARTIAL_FLAG | REARG_FLAG) && !data[4].length && data[9] == 1) {
                        wrapper = wrapper[getFuncName(data[0])].apply(wrapper, data[3]);
                    } else {
                        wrapper = (func.length == 1 && isLaziable(func)) ? wrapper[funcName]() : wrapper.thru(func);
                    }
                }
                return function() {
                    var args = arguments,
                        value = args[0];

                    if (wrapper && args.length == 1 && isArray(value) && value.length >= LARGE_ARRAY_SIZE) {
                        return wrapper.plant(value).value();
                    }
                    var index = 0,
                        result = length ? funcs[index].apply(this, args) : value;

                    while (++index < length) {
                        result = funcs[index].call(this, result);
                    }
                    return result;
                };
            });
        }

        /**
         * Creates a function that wraps `func` to invoke it with optional `this`
         * binding of `thisArg`, partial application, and currying.
         *
         * @private
         * @param {Function|string} func The function or method name to wrap.
         * @param {number} bitmask The bitmask of wrapper flags. See `createWrapper` for more details.
         * @param {*} [thisArg] The `this` binding of `func`.
         * @param {Array} [partials] The arguments to prepend to those provided to the new function.
         * @param {Array} [holders] The `partials` placeholder indexes.
         * @param {Array} [partialsRight] The arguments to append to those provided to the new function.
         * @param {Array} [holdersRight] The `partialsRight` placeholder indexes.
         * @param {Array} [argPos] The argument positions of the new function.
         * @param {number} [ary] The arity cap of `func`.
         * @param {number} [arity] The arity of `func`.
         * @returns {Function} Returns the new wrapped function.
         */
        function createHybridWrapper(func, bitmask, thisArg, partials, holders, partialsRight, holdersRight, argPos, ary, arity) {
            var isAry = bitmask & ARY_FLAG,
                isBind = bitmask & BIND_FLAG,
                isBindKey = bitmask & BIND_KEY_FLAG,
                isCurry = bitmask & CURRY_FLAG,
                isCurryRight = bitmask & CURRY_RIGHT_FLAG,
                isFlip = bitmask & FLIP_FLAG,
                Ctor = isBindKey ? undefined : createCtorWrapper(func);

            function wrapper() {
                var length = arguments.length,
                    index = length,
                    args = Array(length);

                while (index--) {
                    args[index] = arguments[index];
                }
                if (partials) {
                    args = composeArgs(args, partials, holders);
                }
                if (partialsRight) {
                    args = composeArgsRight(args, partialsRight, holdersRight);
                }
                if (isCurry || isCurryRight) {
                    var placeholder = lodash.placeholder || wrapper.placeholder,
                        argsHolders = replaceHolders(args, placeholder);

                    length -= argsHolders.length;
                    if (length < arity) {
                        return createRecurryWrapper(func, bitmask, createHybridWrapper, placeholder, thisArg, args, argsHolders, argPos, ary, arity - length);
                    }
                }
                var thisBinding = isBind ? thisArg : this,
                    fn = isBindKey ? thisBinding[func] : func;

                if (argPos) {
                    args = reorder(args, argPos);
                } else if (isFlip && args.length > 1) {
                    args.reverse();
                }
                if (isAry && ary < args.length) {
                    args.length = ary;
                }
                if (this && this !== root && this instanceof wrapper) {
                    fn = Ctor || createCtorWrapper(fn);
                }
                return fn.apply(thisBinding, args);
            }
            return wrapper;
        }

        /**
         * Creates a function like `_.invertBy`.
         *
         * @private
         * @param {Function} setter The function to set accumulator values.
         * @param {Function} toIteratee The function to resolve iteratees.
         * @returns {Function} Returns the new inverter function.
         */
        function createInverter(setter, toIteratee) {
            return function(object, iteratee) {
                return baseInverter(object, setter, toIteratee(iteratee), {});
            };
        }

        /**
         * Creates a function like `_.over`.
         *
         * @private
         * @param {Function} arrayFunc The function to iterate over iteratees.
         * @returns {Function} Returns the new invoker function.
         */
        function createOver(arrayFunc) {
            return rest(function(iteratees) {
                iteratees = arrayMap(baseFlatten(iteratees), getIteratee());
                return rest(function(args) {
                    var thisArg = this;
                    return arrayFunc(iteratees, function(iteratee) {
                        return apply(iteratee, thisArg, args);
                    });
                });
            });
        }

        /**
         * Creates the padding for `string` based on `length`. The `chars` string
         * is truncated if the number of characters exceeds `length`.
         *
         * @private
         * @param {string} string The string to create padding for.
         * @param {number} [length=0] The padding length.
         * @param {string} [chars=' '] The string used as padding.
         * @returns {string} Returns the padding for `string`.
         */
        function createPadding(string, length, chars) {
            length = toInteger(length);

            var strLength = stringSize(string);
            if (!length || strLength >= length) {
                return '';
            }
            var padLength = length - strLength;
            chars = chars === undefined ? ' ' : (chars + '');

            var result = repeat(chars, nativeCeil(padLength / stringSize(chars)));
            return reHasComplexSymbol.test(chars)
                ? stringToArray(result).slice(0, padLength).join('')
                : result.slice(0, padLength);
        }

        /**
         * Creates a function that wraps `func` to invoke it with the optional `this`
         * binding of `thisArg` and the `partials` prepended to those provided to
         * the wrapper.
         *
         * @private
         * @param {Function} func The function to wrap.
         * @param {number} bitmask The bitmask of wrapper flags. See `createWrapper` for more details.
         * @param {*} thisArg The `this` binding of `func`.
         * @param {Array} partials The arguments to prepend to those provided to the new function.
         * @returns {Function} Returns the new wrapped function.
         */
        function createPartialWrapper(func, bitmask, thisArg, partials) {
            var isBind = bitmask & BIND_FLAG,
                Ctor = createCtorWrapper(func);

            function wrapper() {
                var argsIndex = -1,
                    argsLength = arguments.length,
                    leftIndex = -1,
                    leftLength = partials.length,
                    args = Array(leftLength + argsLength),
                    fn = (this && this !== root && this instanceof wrapper) ? Ctor : func;

                while (++leftIndex < leftLength) {
                    args[leftIndex] = partials[leftIndex];
                }
                while (argsLength--) {
                    args[leftIndex++] = arguments[++argsIndex];
                }
                return apply(fn, isBind ? thisArg : this, args);
            }
            return wrapper;
        }

        /**
         * Creates a `_.range` or `_.rangeRight` function.
         *
         * @private
         * @param {boolean} [fromRight] Specify iterating from right to left.
         * @returns {Function} Returns the new range function.
         */
        function createRange(fromRight) {
            return function(start, end, step) {
                if (step && typeof step != 'number' && isIterateeCall(start, end, step)) {
                    end = step = undefined;
                }
                // Ensure the sign of `-0` is preserved.
                start = toNumber(start);
                start = start === start ? start : 0;
                if (end === undefined) {
                    end = start;
                    start = 0;
                } else {
                    end = toNumber(end) || 0;
                }
                step = step === undefined ? (start < end ? 1 : -1) : (toNumber(step) || 0);
                return baseRange(start, end, step, fromRight);
            };
        }

        /**
         * Creates a function that wraps `func` to continue currying.
         *
         * @private
         * @param {Function} func The function to wrap.
         * @param {number} bitmask The bitmask of wrapper flags. See `createWrapper` for more details.
         * @param {Function} wrapFunc The function to create the `func` wrapper.
         * @param {*} placeholder The placeholder to replace.
         * @param {*} [thisArg] The `this` binding of `func`.
         * @param {Array} [partials] The arguments to prepend to those provided to the new function.
         * @param {Array} [holders] The `partials` placeholder indexes.
         * @param {Array} [argPos] The argument positions of the new function.
         * @param {number} [ary] The arity cap of `func`.
         * @param {number} [arity] The arity of `func`.
         * @returns {Function} Returns the new wrapped function.
         */
        function createRecurryWrapper(func, bitmask, wrapFunc, placeholder, thisArg, partials, holders, argPos, ary, arity) {
            var isCurry = bitmask & CURRY_FLAG,
                newArgPos = argPos ? copyArray(argPos) : undefined,
                newsHolders = isCurry ? holders : undefined,
                newHoldersRight = isCurry ? undefined : holders,
                newPartials = isCurry ? partials : undefined,
                newPartialsRight = isCurry ? undefined : partials;

            bitmask |= (isCurry ? PARTIAL_FLAG : PARTIAL_RIGHT_FLAG);
            bitmask &= ~(isCurry ? PARTIAL_RIGHT_FLAG : PARTIAL_FLAG);

            if (!(bitmask & CURRY_BOUND_FLAG)) {
                bitmask &= ~(BIND_FLAG | BIND_KEY_FLAG);
            }
            var newData = [func, bitmask, thisArg, newPartials, newsHolders, newPartialsRight, newHoldersRight, newArgPos, ary, arity],
                result = wrapFunc.apply(undefined, newData);

            if (isLaziable(func)) {
                setData(result, newData);
            }
            result.placeholder = placeholder;
            return result;
        }

        /**
         * Creates a function like `_.round`.
         *
         * @private
         * @param {string} methodName The name of the `Math` method to use when rounding.
         * @returns {Function} Returns the new round function.
         */
        function createRound(methodName) {
            var func = Math[methodName];
            return function(number, precision) {
                number = toNumber(number);
                precision = toInteger(precision);
                if (precision) {
                    // Shift with exponential notation to avoid floating-point issues.
                    // See [MDN](https://mdn.io/round#Examples) for more details.
                    var pair = (toString(number) + 'e').split('e'),
                        value = func(pair[0] + 'e' + (+pair[1] + precision));

                    pair = (toString(value) + 'e').split('e');
                    return +(pair[0] + 'e' + (+pair[1] - precision));
                }
                return func(number);
            };
        }

        /**
         * Creates a set of `values`.
         *
         * @private
         * @param {Array} values The values to add to the set.
         * @returns {Object} Returns the new set.
         */
        var createSet = !(Set && new Set([1, 2]).size === 2) ? noop : function(values) {
            return new Set(values);
        };

        /**
         * Creates a function that either curries or invokes `func` with optional
         * `this` binding and partially applied arguments.
         *
         * @private
         * @param {Function|string} func The function or method name to wrap.
         * @param {number} bitmask The bitmask of wrapper flags.
         *  The bitmask may be composed of the following flags:
         *     1 - `_.bind`
         *     2 - `_.bindKey`
         *     4 - `_.curry` or `_.curryRight` of a bound function
         *     8 - `_.curry`
         *    16 - `_.curryRight`
         *    32 - `_.partial`
         *    64 - `_.partialRight`
         *   128 - `_.rearg`
         *   256 - `_.ary`
         * @param {*} [thisArg] The `this` binding of `func`.
         * @param {Array} [partials] The arguments to be partially applied.
         * @param {Array} [holders] The `partials` placeholder indexes.
         * @param {Array} [argPos] The argument positions of the new function.
         * @param {number} [ary] The arity cap of `func`.
         * @param {number} [arity] The arity of `func`.
         * @returns {Function} Returns the new wrapped function.
         */
        function createWrapper(func, bitmask, thisArg, partials, holders, argPos, ary, arity) {
            var isBindKey = bitmask & BIND_KEY_FLAG;
            if (!isBindKey && typeof func != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            var length = partials ? partials.length : 0;
            if (!length) {
                bitmask &= ~(PARTIAL_FLAG | PARTIAL_RIGHT_FLAG);
                partials = holders = undefined;
            }
            ary = ary === undefined ? ary : nativeMax(toInteger(ary), 0);
            arity = arity === undefined ? arity : toInteger(arity);
            length -= holders ? holders.length : 0;

            if (bitmask & PARTIAL_RIGHT_FLAG) {
                var partialsRight = partials,
                    holdersRight = holders;

                partials = holders = undefined;
            }
            var data = isBindKey ? undefined : getData(func),
                newData = [func, bitmask, thisArg, partials, holders, partialsRight, holdersRight, argPos, ary, arity];

            if (data) {
                mergeData(newData, data);
            }
            func = newData[0];
            bitmask = newData[1];
            thisArg = newData[2];
            partials = newData[3];
            holders = newData[4];
            arity = newData[9] = newData[9] == null
                ? (isBindKey ? 0 : func.length)
                : nativeMax(newData[9] - length, 0);

            if (!arity && bitmask & (CURRY_FLAG | CURRY_RIGHT_FLAG)) {
                bitmask &= ~(CURRY_FLAG | CURRY_RIGHT_FLAG);
            }
            if (!bitmask || bitmask == BIND_FLAG) {
                var result = createBaseWrapper(func, bitmask, thisArg);
            } else if (bitmask == CURRY_FLAG || bitmask == CURRY_RIGHT_FLAG) {
                result = createCurryWrapper(func, bitmask, arity);
            } else if ((bitmask == PARTIAL_FLAG || bitmask == (BIND_FLAG | PARTIAL_FLAG)) && !holders.length) {
                result = createPartialWrapper(func, bitmask, thisArg, partials);
            } else {
                result = createHybridWrapper.apply(undefined, newData);
            }
            var setter = data ? baseSetData : setData;
            return setter(result, newData);
        }

        /**
         * A specialized version of `baseIsEqualDeep` for arrays with support for
         * partial deep comparisons.
         *
         * @private
         * @param {Array} array The array to compare.
         * @param {Array} other The other array to compare.
         * @param {Function} equalFunc The function to determine equivalents of values.
         * @param {Function} [customizer] The function to customize comparisons.
         * @param {number} [bitmask] The bitmask of comparison flags. See `baseIsEqual` for more details.
         * @param {Object} [stack] Tracks traversed `array` and `other` objects.
         * @returns {boolean} Returns `true` if the arrays are equivalent, else `false`.
         */
        function equalArrays(array, other, equalFunc, customizer, bitmask, stack) {
            var index = -1,
                isPartial = bitmask & PARTIAL_COMPARE_FLAG,
                isUnordered = bitmask & UNORDERED_COMPARE_FLAG,
                arrLength = array.length,
                othLength = other.length;

            if (arrLength != othLength && !(isPartial && othLength > arrLength)) {
                return false;
            }
            // Assume cyclic values are equal.
            var stacked = stack.get(array);
            if (stacked) {
                return stacked == other;
            }
            var result = true;
            stack.set(array, other);

            // Ignore non-index properties.
            while (++index < arrLength) {
                var arrValue = array[index],
                    othValue = other[index];

                if (customizer) {
                    var compared = isPartial
                        ? customizer(othValue, arrValue, index, other, array, stack)
                        : customizer(arrValue, othValue, index, array, other, stack);
                }
                if (compared !== undefined) {
                    if (compared) {
                        continue;
                    }
                    result = false;
                    break;
                }
                // Recursively compare arrays (susceptible to call stack limits).
                if (isUnordered) {
                    if (!arraySome(other, function(othValue) {
                            return arrValue === othValue || equalFunc(arrValue, othValue, customizer, bitmask, stack);
                        })) {
                        result = false;
                        break;
                    }
                } else if (!(arrValue === othValue || equalFunc(arrValue, othValue, customizer, bitmask, stack))) {
                    result = false;
                    break;
                }
            }
            stack['delete'](array);
            return result;
        }

        /**
         * A specialized version of `baseIsEqualDeep` for comparing objects of
         * the same `toStringTag`.
         *
         * **Note:** This function only supports comparing values with tags of
         * `Boolean`, `Date`, `Error`, `Number`, `RegExp`, or `String`.
         *
         * @private
         * @param {Object} object The object to compare.
         * @param {Object} other The other object to compare.
         * @param {string} tag The `toStringTag` of the objects to compare.
         * @param {Function} equalFunc The function to determine equivalents of values.
         * @param {Function} [customizer] The function to customize comparisons.
         * @param {number} [bitmask] The bitmask of comparison flags. See `baseIsEqual` for more details.
         * @returns {boolean} Returns `true` if the objects are equivalent, else `false`.
         */
        function equalByTag(object, other, tag, equalFunc, customizer, bitmask) {
            switch (tag) {
                case arrayBufferTag:
                    if ((object.byteLength != other.byteLength) ||
                        !equalFunc(new Uint8Array(object), new Uint8Array(other))) {
                        return false;
                    }
                    return true;

                case boolTag:
                case dateTag:
                    // Coerce dates and booleans to numbers, dates to milliseconds and booleans
                    // to `1` or `0` treating invalid dates coerced to `NaN` as not equal.
                    return +object == +other;

                case errorTag:
                    return object.name == other.name && object.message == other.message;

                case numberTag:
                    // Treat `NaN` vs. `NaN` as equal.
                    return (object != +object) ? other != +other : object == +other;

                case regexpTag:
                case stringTag:
                    // Coerce regexes to strings and treat strings primitives and string
                    // objects as equal. See https://es5.github.io/#x15.10.6.4 for more details.
                    return object == (other + '');

                case mapTag:
                    var convert = mapToArray;

                case setTag:
                    var isPartial = bitmask & PARTIAL_COMPARE_FLAG;
                    convert || (convert = setToArray);

                    // Recursively compare objects (susceptible to call stack limits).
                    return (isPartial || object.size == other.size) &&
                        equalFunc(convert(object), convert(other), customizer, bitmask | UNORDERED_COMPARE_FLAG);

                case symbolTag:
                    return !!Symbol && (symbolValueOf.call(object) == symbolValueOf.call(other));
            }
            return false;
        }

        /**
         * A specialized version of `baseIsEqualDeep` for objects with support for
         * partial deep comparisons.
         *
         * @private
         * @param {Object} object The object to compare.
         * @param {Object} other The other object to compare.
         * @param {Function} equalFunc The function to determine equivalents of values.
         * @param {Function} [customizer] The function to customize comparisons.
         * @param {number} [bitmask] The bitmask of comparison flags. See `baseIsEqual` for more details.
         * @param {Object} [stack] Tracks traversed `object` and `other` objects.
         * @returns {boolean} Returns `true` if the objects are equivalent, else `false`.
         */
        function equalObjects(object, other, equalFunc, customizer, bitmask, stack) {
            var isPartial = bitmask & PARTIAL_COMPARE_FLAG,
                objProps = keys(object),
                objLength = objProps.length,
                othProps = keys(other),
                othLength = othProps.length;

            if (objLength != othLength && !isPartial) {
                return false;
            }
            var index = objLength;
            while (index--) {
                var key = objProps[index];
                if (!(isPartial ? key in other : baseHas(other, key))) {
                    return false;
                }
            }
            // Assume cyclic values are equal.
            var stacked = stack.get(object);
            if (stacked) {
                return stacked == other;
            }
            var result = true;
            stack.set(object, other);

            var skipCtor = isPartial;
            while (++index < objLength) {
                key = objProps[index];
                var objValue = object[key],
                    othValue = other[key];

                if (customizer) {
                    var compared = isPartial
                        ? customizer(othValue, objValue, key, other, object, stack)
                        : customizer(objValue, othValue, key, object, other, stack);
                }
                // Recursively compare objects (susceptible to call stack limits).
                if (!(compared === undefined
                            ? (objValue === othValue || equalFunc(objValue, othValue, customizer, bitmask, stack))
                            : compared
                    )) {
                    result = false;
                    break;
                }
                skipCtor || (skipCtor = key == 'constructor');
            }
            if (result && !skipCtor) {
                var objCtor = object.constructor,
                    othCtor = other.constructor;

                // Non `Object` object instances with different constructors are not equal.
                if (objCtor != othCtor &&
                    ('constructor' in object && 'constructor' in other) &&
                    !(typeof objCtor == 'function' && objCtor instanceof objCtor &&
                    typeof othCtor == 'function' && othCtor instanceof othCtor)) {
                    result = false;
                }
            }
            stack['delete'](object);
            return result;
        }

        /**
         * Gets metadata for `func`.
         *
         * @private
         * @param {Function} func The function to query.
         * @returns {*} Returns the metadata for `func`.
         */
        var getData = !metaMap ? noop : function(func) {
            return metaMap.get(func);
        };

        /**
         * Gets the name of `func`.
         *
         * @private
         * @param {Function} func The function to query.
         * @returns {string} Returns the function name.
         */
        function getFuncName(func) {
            var result = (func.name + ''),
                array = realNames[result],
                length = hasOwnProperty.call(realNames, result) ? array.length : 0;

            while (length--) {
                var data = array[length],
                    otherFunc = data.func;
                if (otherFunc == null || otherFunc == func) {
                    return data.name;
                }
            }
            return result;
        }

        /**
         * Gets the appropriate "iteratee" function. If the `_.iteratee` method is
         * customized this function returns the custom method, otherwise it returns
         * `baseIteratee`. If arguments are provided the chosen function is invoked
         * with them and its result is returned.
         *
         * @private
         * @param {*} [value] The value to convert to an iteratee.
         * @param {number} [arity] The arity of the created iteratee.
         * @returns {Function} Returns the chosen function or its result.
         */
        function getIteratee() {
            var result = lodash.iteratee || iteratee;
            result = result === iteratee ? baseIteratee : result;
            return arguments.length ? result(arguments[0], arguments[1]) : result;
        }

        /**
         * Gets the "length" property value of `object`.
         *
         * **Note:** This function is used to avoid a [JIT bug](https://bugs.webkit.org/show_bug.cgi?id=142792)
         * that affects Safari on at least iOS 8.1-8.3 ARM64.
         *
         * @private
         * @param {Object} object The object to query.
         * @returns {*} Returns the "length" value.
         */
        var getLength = baseProperty('length');

        /**
         * Gets the property names, values, and compare flags of `object`.
         *
         * @private
         * @param {Object} object The object to query.
         * @returns {Array} Returns the match data of `object`.
         */
        function getMatchData(object) {
            var result = toPairs(object),
                length = result.length;

            while (length--) {
                result[length][2] = isStrictComparable(result[length][1]);
            }
            return result;
        }

        /**
         * Gets the native function at `key` of `object`.
         *
         * @private
         * @param {Object} object The object to query.
         * @param {string} key The key of the method to get.
         * @returns {*} Returns the function if it's native, else `undefined`.
         */
        function getNative(object, key) {
            var value = object == null ? undefined : object[key];
            return isNative(value) ? value : undefined;
        }

        /**
         * Creates an array of the own symbol properties of `object`.
         *
         * @private
         * @param {Object} object The object to query.
         * @returns {Array} Returns the array of symbols.
         */
        var getSymbols = getOwnPropertySymbols || function() {
                return [];
            };

        /**
         * Gets the `toStringTag` of `value`.
         *
         * @private
         * @param {*} value The value to query.
         * @returns {string} Returns the `toStringTag`.
         */
        function getTag(value) {
            return objectToString.call(value);
        }

        // Fallback for IE 11 providing `toStringTag` values for maps, sets, and weakmaps.
        if ((Map && getTag(new Map) != mapTag) ||
            (Set && getTag(new Set) != setTag) ||
            (WeakMap && getTag(new WeakMap) != weakMapTag)) {
            getTag = function(value) {
                var result = objectToString.call(value),
                    Ctor = result == objectTag ? value.constructor : null,
                    ctorString = typeof Ctor == 'function' ? funcToString.call(Ctor) : '';

                if (ctorString) {
                    switch (ctorString) {
                        case mapCtorString: return mapTag;
                        case setCtorString: return setTag;
                        case weakMapCtorString: return weakMapTag;
                    }
                }
                return result;
            };
        }

        /**
         * Gets the view, applying any `transforms` to the `start` and `end` positions.
         *
         * @private
         * @param {number} start The start of the view.
         * @param {number} end The end of the view.
         * @param {Array} transforms The transformations to apply to the view.
         * @returns {Object} Returns an object containing the `start` and `end`
         *  positions of the view.
         */
        function getView(start, end, transforms) {
            var index = -1,
                length = transforms.length;

            while (++index < length) {
                var data = transforms[index],
                    size = data.size;

                switch (data.type) {
                    case 'drop':      start += size; break;
                    case 'dropRight': end -= size; break;
                    case 'take':      end = nativeMin(end, start + size); break;
                    case 'takeRight': start = nativeMax(start, end - size); break;
                }
            }
            return { 'start': start, 'end': end };
        }

        /**
         * Checks if `path` exists on `object`.
         *
         * @private
         * @param {Object} object The object to query.
         * @param {Array|string} path The path to check.
         * @param {Function} hasFunc The function to check properties.
         * @returns {boolean} Returns `true` if `path` exists, else `false`.
         */
        function hasPath(object, path, hasFunc) {
            if (object == null) {
                return false;
            }
            var result = hasFunc(object, path);
            if (!result && !isKey(path)) {
                path = baseToPath(path);
                object = parent(object, path);
                if (object != null) {
                    path = last(path);
                    result = hasFunc(object, path);
                }
            }
            var length = object ? object.length : undefined;
            return result || (
                    !!length && isLength(length) && isIndex(path, length) &&
                    (isArray(object) || isString(object) || isArguments(object))
                );
        }

        /**
         * Initializes an array clone.
         *
         * @private
         * @param {Array} array The array to clone.
         * @returns {Array} Returns the initialized clone.
         */
        function initCloneArray(array) {
            var length = array.length,
                result = array.constructor(length);

            // Add properties assigned by `RegExp#exec`.
            if (length && typeof array[0] == 'string' && hasOwnProperty.call(array, 'index')) {
                result.index = array.index;
                result.input = array.input;
            }
            return result;
        }

        /**
         * Initializes an object clone.
         *
         * @private
         * @param {Object} object The object to clone.
         * @returns {Object} Returns the initialized clone.
         */
        function initCloneObject(object) {
            if (isPrototype(object)) {
                return {};
            }
            var Ctor = object.constructor;
            return baseCreate(isFunction(Ctor) ? Ctor.prototype : undefined);
        }

        /**
         * Initializes an object clone based on its `toStringTag`.
         *
         * **Note:** This function only supports cloning values with tags of
         * `Boolean`, `Date`, `Error`, `Number`, `RegExp`, or `String`.
         *
         * @private
         * @param {Object} object The object to clone.
         * @param {string} tag The `toStringTag` of the object to clone.
         * @param {boolean} [isDeep] Specify a deep clone.
         * @returns {Object} Returns the initialized clone.
         */
        function initCloneByTag(object, tag, isDeep) {
            var Ctor = object.constructor;
            switch (tag) {
                case arrayBufferTag:
                    return cloneArrayBuffer(object);

                case boolTag:
                case dateTag:
                    return new Ctor(+object);

                case float32Tag: case float64Tag:
                case int8Tag: case int16Tag: case int32Tag:
                case uint8Tag: case uint8ClampedTag: case uint16Tag: case uint32Tag:
                return cloneTypedArray(object, isDeep);

                case mapTag:
                    return cloneMap(object);

                case numberTag:
                case stringTag:
                    return new Ctor(object);

                case regexpTag:
                    return cloneRegExp(object);

                case setTag:
                    return cloneSet(object);

                case symbolTag:
                    return cloneSymbol(object);
            }
        }

        /**
         * Creates an array of index keys for `object` values of arrays,
         * `arguments` objects, and strings, otherwise `null` is returned.
         *
         * @private
         * @param {Object} object The object to query.
         * @returns {Array|null} Returns index keys, else `null`.
         */
        function indexKeys(object) {
            var length = object ? object.length : undefined;
            if (isLength(length) &&
                (isArray(object) || isString(object) || isArguments(object))) {
                return baseTimes(length, String);
            }
            return null;
        }

        /**
         * Checks if the given arguments are from an iteratee call.
         *
         * @private
         * @param {*} value The potential iteratee value argument.
         * @param {*} index The potential iteratee index or key argument.
         * @param {*} object The potential iteratee object argument.
         * @returns {boolean} Returns `true` if the arguments are from an iteratee call, else `false`.
         */
        function isIterateeCall(value, index, object) {
            if (!isObject(object)) {
                return false;
            }
            var type = typeof index;
            if (type == 'number'
                    ? (isArrayLike(object) && isIndex(index, object.length))
                    : (type == 'string' && index in object)) {
                return eq(object[index], value);
            }
            return false;
        }

        /**
         * Checks if `value` is a property name and not a property path.
         *
         * @private
         * @param {*} value The value to check.
         * @param {Object} [object] The object to query keys on.
         * @returns {boolean} Returns `true` if `value` is a property name, else `false`.
         */
        function isKey(value, object) {
            if (typeof value == 'number') {
                return true;
            }
            return !isArray(value) &&
                (reIsPlainProp.test(value) || !reIsDeepProp.test(value) ||
                (object != null && value in Object(object)));
        }

        /**
         * Checks if `value` is suitable for use as unique object key.
         *
         * @private
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is suitable, else `false`.
         */
        function isKeyable(value) {
            var type = typeof value;
            return type == 'number' || type == 'boolean' ||
                (type == 'string' && value !== '__proto__') || value == null;
        }

        /**
         * Checks if `func` has a lazy counterpart.
         *
         * @private
         * @param {Function} func The function to check.
         * @returns {boolean} Returns `true` if `func` has a lazy counterpart, else `false`.
         */
        function isLaziable(func) {
            var funcName = getFuncName(func),
                other = lodash[funcName];

            if (typeof other != 'function' || !(funcName in LazyWrapper.prototype)) {
                return false;
            }
            if (func === other) {
                return true;
            }
            var data = getData(other);
            return !!data && func === data[0];
        }

        /**
         * Checks if `value` is likely a prototype object.
         *
         * @private
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is a prototype, else `false`.
         */
        function isPrototype(value) {
            var Ctor = value && value.constructor,
                proto = (typeof Ctor == 'function' && Ctor.prototype) || objectProto;

            return value === proto;
        }

        /**
         * Checks if `value` is suitable for strict equality comparisons, i.e. `===`.
         *
         * @private
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` if suitable for strict
         *  equality comparisons, else `false`.
         */
        function isStrictComparable(value) {
            return value === value && !isObject(value);
        }

        /**
         * Merges the function metadata of `source` into `data`.
         *
         * Merging metadata reduces the number of wrappers used to invoke a function.
         * This is possible because methods like `_.bind`, `_.curry`, and `_.partial`
         * may be applied regardless of execution order. Methods like `_.ary` and `_.rearg`
         * modify function arguments, making the order in which they are executed important,
         * preventing the merging of metadata. However, we make an exception for a safe
         * combined case where curried functions have `_.ary` and or `_.rearg` applied.
         *
         * @private
         * @param {Array} data The destination metadata.
         * @param {Array} source The source metadata.
         * @returns {Array} Returns `data`.
         */
        function mergeData(data, source) {
            var bitmask = data[1],
                srcBitmask = source[1],
                newBitmask = bitmask | srcBitmask,
                isCommon = newBitmask < (BIND_FLAG | BIND_KEY_FLAG | ARY_FLAG);

            var isCombo =
                (srcBitmask == ARY_FLAG && (bitmask == CURRY_FLAG)) ||
                (srcBitmask == ARY_FLAG && (bitmask == REARG_FLAG) && (data[7].length <= source[8])) ||
                (srcBitmask == (ARY_FLAG | REARG_FLAG) && (source[7].length <= source[8]) && (bitmask == CURRY_FLAG));

            // Exit early if metadata can't be merged.
            if (!(isCommon || isCombo)) {
                return data;
            }
            // Use source `thisArg` if available.
            if (srcBitmask & BIND_FLAG) {
                data[2] = source[2];
                // Set when currying a bound function.
                newBitmask |= (bitmask & BIND_FLAG) ? 0 : CURRY_BOUND_FLAG;
            }
            // Compose partial arguments.
            var value = source[3];
            if (value) {
                var partials = data[3];
                data[3] = partials ? composeArgs(partials, value, source[4]) : copyArray(value);
                data[4] = partials ? replaceHolders(data[3], PLACEHOLDER) : copyArray(source[4]);
            }
            // Compose partial right arguments.
            value = source[5];
            if (value) {
                partials = data[5];
                data[5] = partials ? composeArgsRight(partials, value, source[6]) : copyArray(value);
                data[6] = partials ? replaceHolders(data[5], PLACEHOLDER) : copyArray(source[6]);
            }
            // Use source `argPos` if available.
            value = source[7];
            if (value) {
                data[7] = copyArray(value);
            }
            // Use source `ary` if it's smaller.
            if (srcBitmask & ARY_FLAG) {
                data[8] = data[8] == null ? source[8] : nativeMin(data[8], source[8]);
            }
            // Use source `arity` if one is not provided.
            if (data[9] == null) {
                data[9] = source[9];
            }
            // Use source `func` and merge bitmasks.
            data[0] = source[0];
            data[1] = newBitmask;

            return data;
        }

        /**
         * Used by `_.defaultsDeep` to customize its `_.merge` use.
         *
         * @private
         * @param {*} objValue The destination value.
         * @param {*} srcValue The source value.
         * @param {string} key The key of the property to merge.
         * @param {Object} object The parent object of `objValue`.
         * @param {Object} source The parent object of `srcValue`.
         * @param {Object} [stack] Tracks traversed source values and their merged counterparts.
         * @returns {*} Returns the value to assign.
         */
        function mergeDefaults(objValue, srcValue, key, object, source, stack) {
            if (isObject(objValue) && isObject(srcValue)) {
                stack.set(srcValue, objValue);
                baseMerge(objValue, srcValue, undefined, mergeDefaults, stack);
            }
            return objValue;
        }

        /**
         * Gets the parent value at `path` of `object`.
         *
         * @private
         * @param {Object} object The object to query.
         * @param {Array} path The path to get the parent value of.
         * @returns {*} Returns the parent value.
         */
        function parent(object, path) {
            return path.length == 1 ? object : get(object, baseSlice(path, 0, -1));
        }

        /**
         * Reorder `array` according to the specified indexes where the element at
         * the first index is assigned as the first element, the element at
         * the second index is assigned as the second element, and so on.
         *
         * @private
         * @param {Array} array The array to reorder.
         * @param {Array} indexes The arranged array indexes.
         * @returns {Array} Returns `array`.
         */
        function reorder(array, indexes) {
            var arrLength = array.length,
                length = nativeMin(indexes.length, arrLength),
                oldArray = copyArray(array);

            while (length--) {
                var index = indexes[length];
                array[length] = isIndex(index, arrLength) ? oldArray[index] : undefined;
            }
            return array;
        }

        /**
         * Sets metadata for `func`.
         *
         * **Note:** If this function becomes hot, i.e. is invoked a lot in a short
         * period of time, it will trip its breaker and transition to an identity function
         * to avoid garbage collection pauses in V8. See [V8 issue 2070](https://code.google.com/p/v8/issues/detail?id=2070)
         * for more details.
         *
         * @private
         * @param {Function} func The function to associate metadata with.
         * @param {*} data The metadata.
         * @returns {Function} Returns `func`.
         */
        var setData = (function() {
            var count = 0,
                lastCalled = 0;

            return function(key, value) {
                var stamp = now(),
                    remaining = HOT_SPAN - (stamp - lastCalled);

                lastCalled = stamp;
                if (remaining > 0) {
                    if (++count >= HOT_COUNT) {
                        return key;
                    }
                } else {
                    count = 0;
                }
                return baseSetData(key, value);
            };
        }());

        /**
         * Converts `string` to a property path array.
         *
         * @private
         * @param {string} string The string to convert.
         * @returns {Array} Returns the property path array.
         */
        function stringToPath(string) {
            var result = [];
            toString(string).replace(rePropName, function(match, number, quote, string) {
                result.push(quote ? string.replace(reEscapeChar, '$1') : (number || match));
            });
            return result;
        }

        /**
         * Converts `value` to an array-like object if it's not one.
         *
         * @private
         * @param {*} value The value to process.
         * @returns {Array} Returns the array-like object.
         */
        function toArrayLikeObject(value) {
            return isArrayLikeObject(value) ? value : [];
        }

        /**
         * Converts `value` to a function if it's not one.
         *
         * @private
         * @param {*} value The value to process.
         * @returns {Function} Returns the function.
         */
        function toFunction(value) {
            return typeof value == 'function' ? value : identity;
        }

        /**
         * Creates a clone of `wrapper`.
         *
         * @private
         * @param {Object} wrapper The wrapper to clone.
         * @returns {Object} Returns the cloned wrapper.
         */
        function wrapperClone(wrapper) {
            if (wrapper instanceof LazyWrapper) {
                return wrapper.clone();
            }
            var result = new LodashWrapper(wrapper.__wrapped__, wrapper.__chain__);
            result.__actions__ = copyArray(wrapper.__actions__);
            result.__index__  = wrapper.__index__;
            result.__values__ = wrapper.__values__;
            return result;
        }

        /*------------------------------------------------------------------------*/

        /**
         * Creates an array of elements split into groups the length of `size`.
         * If `array` can't be split evenly, the final chunk will be the remaining
         * elements.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to process.
         * @param {number} [size=0] The length of each chunk.
         * @returns {Array} Returns the new array containing chunks.
         * @example
         *
         * _.chunk(['a', 'b', 'c', 'd'], 2);
         * // => [['a', 'b'], ['c', 'd']]
         *
         * _.chunk(['a', 'b', 'c', 'd'], 3);
         * // => [['a', 'b', 'c'], ['d']]
         */
        function chunk(array, size) {
            size = nativeMax(toInteger(size), 0);

            var length = array ? array.length : 0;
            if (!length || size < 1) {
                return [];
            }
            var index = 0,
                resIndex = -1,
                result = Array(nativeCeil(length / size));

            while (index < length) {
                result[++resIndex] = baseSlice(array, index, (index += size));
            }
            return result;
        }

        /**
         * Creates an array with all falsey values removed. The values `false`, `null`,
         * `0`, `""`, `undefined`, and `NaN` are falsey.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to compact.
         * @returns {Array} Returns the new array of filtered values.
         * @example
         *
         * _.compact([0, 1, false, 2, '', 3]);
         * // => [1, 2, 3]
         */
        function compact(array) {
            var index = -1,
                length = array ? array.length : 0,
                resIndex = -1,
                result = [];

            while (++index < length) {
                var value = array[index];
                if (value) {
                    result[++resIndex] = value;
                }
            }
            return result;
        }

        /**
         * Creates a new array concatenating `array` with any additional arrays
         * and/or values.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to concatenate.
         * @param {...*} [values] The values to concatenate.
         * @returns {Array} Returns the new concatenated array.
         * @example
         *
         * var array = [1];
         * var other = _.concat(array, 2, [3], [[4]]);
         *
         * console.log(other);
         * // => [1, 2, 3, [4]]
         *
         * console.log(array);
         * // => [1]
         */
        var concat = rest(function(array, values) {
            if (!isArray(array)) {
                array = array == null ? [] : [Object(array)];
            }
            values = baseFlatten(values);
            return arrayConcat(array, values);
        });

        /**
         * Creates an array of unique `array` values not included in the other
         * given arrays using [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * for equality comparisons.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to inspect.
         * @param {...Array} [values] The values to exclude.
         * @returns {Array} Returns the new array of filtered values.
         * @example
         *
         * _.difference([3, 2, 1], [4, 2]);
         * // => [3, 1]
         */
        var difference = rest(function(array, values) {
            return isArrayLikeObject(array)
                ? baseDifference(array, baseFlatten(values, false, true))
                : [];
        });

        /**
         * This method is like `_.difference` except that it accepts `iteratee` which
         * is invoked for each element of `array` and `values` to generate the criterion
         * by which uniqueness is computed. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to inspect.
         * @param {...Array} [values] The values to exclude.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {Array} Returns the new array of filtered values.
         * @example
         *
         * _.differenceBy([3.1, 2.2, 1.3], [4.4, 2.5], Math.floor);
         * // => [3.1, 1.3]
         *
         * // The `_.property` iteratee shorthand.
         * _.differenceBy([{ 'x': 2 }, { 'x': 1 }], [{ 'x': 1 }], 'x');
         * // => [{ 'x': 2 }]
         */
        var differenceBy = rest(function(array, values) {
            var iteratee = last(values);
            if (isArrayLikeObject(iteratee)) {
                iteratee = undefined;
            }
            return isArrayLikeObject(array)
                ? baseDifference(array, baseFlatten(values, false, true), getIteratee(iteratee))
                : [];
        });

        /**
         * This method is like `_.difference` except that it accepts `comparator`
         * which is invoked to compare elements of `array` to `values`. The comparator
         * is invoked with two arguments: (arrVal, othVal).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to inspect.
         * @param {...Array} [values] The values to exclude.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new array of filtered values.
         * @example
         *
         * var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }];
         *
         * _.differenceWith(objects, [{ 'x': 1, 'y': 2 }], _.isEqual);
         * // => [{ 'x': 2, 'y': 1 }]
         */
        var differenceWith = rest(function(array, values) {
            var comparator = last(values);
            if (isArrayLikeObject(comparator)) {
                comparator = undefined;
            }
            return isArrayLikeObject(array)
                ? baseDifference(array, baseFlatten(values, false, true), undefined, comparator)
                : [];
        });

        /**
         * Creates a slice of `array` with `n` elements dropped from the beginning.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @param {number} [n=1] The number of elements to drop.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * _.drop([1, 2, 3]);
         * // => [2, 3]
         *
         * _.drop([1, 2, 3], 2);
         * // => [3]
         *
         * _.drop([1, 2, 3], 5);
         * // => []
         *
         * _.drop([1, 2, 3], 0);
         * // => [1, 2, 3]
         */
        function drop(array, n, guard) {
            var length = array ? array.length : 0;
            if (!length) {
                return [];
            }
            n = (guard || n === undefined) ? 1 : toInteger(n);
            return baseSlice(array, n < 0 ? 0 : n, length);
        }

        /**
         * Creates a slice of `array` with `n` elements dropped from the end.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @param {number} [n=1] The number of elements to drop.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * _.dropRight([1, 2, 3]);
         * // => [1, 2]
         *
         * _.dropRight([1, 2, 3], 2);
         * // => [1]
         *
         * _.dropRight([1, 2, 3], 5);
         * // => []
         *
         * _.dropRight([1, 2, 3], 0);
         * // => [1, 2, 3]
         */
        function dropRight(array, n, guard) {
            var length = array ? array.length : 0;
            if (!length) {
                return [];
            }
            n = (guard || n === undefined) ? 1 : toInteger(n);
            n = length - n;
            return baseSlice(array, 0, n < 0 ? 0 : n);
        }

        /**
         * Creates a slice of `array` excluding elements dropped from the end.
         * Elements are dropped until `predicate` returns falsey. The predicate is
         * invoked with three arguments: (value, index, array).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'active': true },
         *   { 'user': 'fred',    'active': false },
         *   { 'user': 'pebbles', 'active': false }
         * ];
         *
         * _.dropRightWhile(users, function(o) { return !o.active; });
         * // => objects for ['barney']
         *
         * // The `_.matches` iteratee shorthand.
         * _.dropRightWhile(users, { 'user': 'pebbles', 'active': false });
         * // => objects for ['barney', 'fred']
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.dropRightWhile(users, ['active', false]);
         * // => objects for ['barney']
         *
         * // The `_.property` iteratee shorthand.
         * _.dropRightWhile(users, 'active');
         * // => objects for ['barney', 'fred', 'pebbles']
         */
        function dropRightWhile(array, predicate) {
            return (array && array.length)
                ? baseWhile(array, getIteratee(predicate, 3), true, true)
                : [];
        }

        /**
         * Creates a slice of `array` excluding elements dropped from the beginning.
         * Elements are dropped until `predicate` returns falsey. The predicate is
         * invoked with three arguments: (value, index, array).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'active': false },
         *   { 'user': 'fred',    'active': false },
         *   { 'user': 'pebbles', 'active': true }
         * ];
         *
         * _.dropWhile(users, function(o) { return !o.active; });
         * // => objects for ['pebbles']
         *
         * // The `_.matches` iteratee shorthand.
         * _.dropWhile(users, { 'user': 'barney', 'active': false });
         * // => objects for ['fred', 'pebbles']
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.dropWhile(users, ['active', false]);
         * // => objects for ['pebbles']
         *
         * // The `_.property` iteratee shorthand.
         * _.dropWhile(users, 'active');
         * // => objects for ['barney', 'fred', 'pebbles']
         */
        function dropWhile(array, predicate) {
            return (array && array.length)
                ? baseWhile(array, getIteratee(predicate, 3), true)
                : [];
        }

        /**
         * Fills elements of `array` with `value` from `start` up to, but not
         * including, `end`.
         *
         * **Note:** This method mutates `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to fill.
         * @param {*} value The value to fill `array` with.
         * @param {number} [start=0] The start position.
         * @param {number} [end=array.length] The end position.
         * @returns {Array} Returns `array`.
         * @example
         *
         * var array = [1, 2, 3];
         *
         * _.fill(array, 'a');
         * console.log(array);
         * // => ['a', 'a', 'a']
         *
         * _.fill(Array(3), 2);
         * // => [2, 2, 2]
         *
         * _.fill([4, 6, 8, 10], '*', 1, 3);
         * // => [4, '*', '*', 10]
         */
        function fill(array, value, start, end) {
            var length = array ? array.length : 0;
            if (!length) {
                return [];
            }
            if (start && typeof start != 'number' && isIterateeCall(array, value, start)) {
                start = 0;
                end = length;
            }
            return baseFill(array, value, start, end);
        }

        /**
         * This method is like `_.find` except that it returns the index of the first
         * element `predicate` returns truthy for instead of the element itself.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to search.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {number} Returns the index of the found element, else `-1`.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'active': false },
         *   { 'user': 'fred',    'active': false },
         *   { 'user': 'pebbles', 'active': true }
         * ];
         *
         * _.findIndex(users, function(o) { return o.user == 'barney'; });
         * // => 0
         *
         * // The `_.matches` iteratee shorthand.
         * _.findIndex(users, { 'user': 'fred', 'active': false });
         * // => 1
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.findIndex(users, ['active', false]);
         * // => 0
         *
         * // The `_.property` iteratee shorthand.
         * _.findIndex(users, 'active');
         * // => 2
         */
        function findIndex(array, predicate) {
            return (array && array.length)
                ? baseFindIndex(array, getIteratee(predicate, 3))
                : -1;
        }

        /**
         * This method is like `_.findIndex` except that it iterates over elements
         * of `collection` from right to left.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to search.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {number} Returns the index of the found element, else `-1`.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'active': true },
         *   { 'user': 'fred',    'active': false },
         *   { 'user': 'pebbles', 'active': false }
         * ];
         *
         * _.findLastIndex(users, function(o) { return o.user == 'pebbles'; });
         * // => 2
         *
         * // The `_.matches` iteratee shorthand.
         * _.findLastIndex(users, { 'user': 'barney', 'active': true });
         * // => 0
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.findLastIndex(users, ['active', false]);
         * // => 2
         *
         * // The `_.property` iteratee shorthand.
         * _.findLastIndex(users, 'active');
         * // => 0
         */
        function findLastIndex(array, predicate) {
            return (array && array.length)
                ? baseFindIndex(array, getIteratee(predicate, 3), true)
                : -1;
        }

        /**
         * Flattens `array` a single level.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to flatten.
         * @returns {Array} Returns the new flattened array.
         * @example
         *
         * _.flatten([1, [2, 3, [4]]]);
         * // => [1, 2, 3, [4]]
         */
        function flatten(array) {
            var length = array ? array.length : 0;
            return length ? baseFlatten(array) : [];
        }

        /**
         * This method is like `_.flatten` except that it recursively flattens `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to recursively flatten.
         * @returns {Array} Returns the new flattened array.
         * @example
         *
         * _.flattenDeep([1, [2, 3, [4]]]);
         * // => [1, 2, 3, 4]
         */
        function flattenDeep(array) {
            var length = array ? array.length : 0;
            return length ? baseFlatten(array, true) : [];
        }

        /**
         * The inverse of `_.toPairs`; this method returns an object composed
         * from key-value `pairs`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} pairs The key-value pairs.
         * @returns {Object} Returns the new object.
         * @example
         *
         * _.fromPairs([['fred', 30], ['barney', 40]]);
         * // => { 'fred': 30, 'barney': 40 }
         */
        function fromPairs(pairs) {
            var index = -1,
                length = pairs ? pairs.length : 0,
                result = {};

            while (++index < length) {
                var pair = pairs[index];
                result[pair[0]] = pair[1];
            }
            return result;
        }

        /**
         * Gets the first element of `array`.
         *
         * @static
         * @memberOf _
         * @alias first
         * @category Array
         * @param {Array} array The array to query.
         * @returns {*} Returns the first element of `array`.
         * @example
         *
         * _.head([1, 2, 3]);
         * // => 1
         *
         * _.head([]);
         * // => undefined
         */
        function head(array) {
            return array ? array[0] : undefined;
        }

        /**
         * Gets the index at which the first occurrence of `value` is found in `array`
         * using [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * for equality comparisons. If `fromIndex` is negative, it's used as the offset
         * from the end of `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to search.
         * @param {*} value The value to search for.
         * @param {number} [fromIndex=0] The index to search from.
         * @returns {number} Returns the index of the matched value, else `-1`.
         * @example
         *
         * _.indexOf([1, 2, 1, 2], 2);
         * // => 1
         *
         * // Search from the `fromIndex`.
         * _.indexOf([1, 2, 1, 2], 2, 2);
         * // => 3
         */
        function indexOf(array, value, fromIndex) {
            var length = array ? array.length : 0;
            if (!length) {
                return -1;
            }
            fromIndex = toInteger(fromIndex);
            if (fromIndex < 0) {
                fromIndex = nativeMax(length + fromIndex, 0);
            }
            return baseIndexOf(array, value, fromIndex);
        }

        /**
         * Gets all but the last element of `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * _.initial([1, 2, 3]);
         * // => [1, 2]
         */
        function initial(array) {
            return dropRight(array, 1);
        }

        /**
         * Creates an array of unique values that are included in all given arrays
         * using [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * for equality comparisons.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @returns {Array} Returns the new array of shared values.
         * @example
         *
         * _.intersection([2, 1], [4, 2], [1, 2]);
         * // => [2]
         */
        var intersection = rest(function(arrays) {
            var mapped = arrayMap(arrays, toArrayLikeObject);
            return (mapped.length && mapped[0] === arrays[0])
                ? baseIntersection(mapped)
                : [];
        });

        /**
         * This method is like `_.intersection` except that it accepts `iteratee`
         * which is invoked for each element of each `arrays` to generate the criterion
         * by which uniqueness is computed. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {Array} Returns the new array of shared values.
         * @example
         *
         * _.intersectionBy([2.1, 1.2], [4.3, 2.4], Math.floor);
         * // => [2.1]
         *
         * // The `_.property` iteratee shorthand.
         * _.intersectionBy([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x');
         * // => [{ 'x': 1 }]
         */
        var intersectionBy = rest(function(arrays) {
            var iteratee = last(arrays),
                mapped = arrayMap(arrays, toArrayLikeObject);

            if (iteratee === last(mapped)) {
                iteratee = undefined;
            } else {
                mapped.pop();
            }
            return (mapped.length && mapped[0] === arrays[0])
                ? baseIntersection(mapped, getIteratee(iteratee))
                : [];
        });

        /**
         * This method is like `_.intersection` except that it accepts `comparator`
         * which is invoked to compare elements of `arrays`. The comparator is invoked
         * with two arguments: (arrVal, othVal).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new array of shared values.
         * @example
         *
         * var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }];
         * var others = [{ 'x': 1, 'y': 1 }, { 'x': 1, 'y': 2 }];
         *
         * _.intersectionWith(objects, others, _.isEqual);
         * // => [{ 'x': 1, 'y': 2 }]
         */
        var intersectionWith = rest(function(arrays) {
            var comparator = last(arrays),
                mapped = arrayMap(arrays, toArrayLikeObject);

            if (comparator === last(mapped)) {
                comparator = undefined;
            } else {
                mapped.pop();
            }
            return (mapped.length && mapped[0] === arrays[0])
                ? baseIntersection(mapped, undefined, comparator)
                : [];
        });

        /**
         * Converts all elements in `array` into a string separated by `separator`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to convert.
         * @param {string} [separator=','] The element separator.
         * @returns {string} Returns the joined string.
         * @example
         *
         * _.join(['a', 'b', 'c'], '~');
         * // => 'a~b~c'
         */
        function join(array, separator) {
            return array ? nativeJoin.call(array, separator) : '';
        }

        /**
         * Gets the last element of `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @returns {*} Returns the last element of `array`.
         * @example
         *
         * _.last([1, 2, 3]);
         * // => 3
         */
        function last(array) {
            var length = array ? array.length : 0;
            return length ? array[length - 1] : undefined;
        }

        /**
         * This method is like `_.indexOf` except that it iterates over elements of
         * `array` from right to left.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to search.
         * @param {*} value The value to search for.
         * @param {number} [fromIndex=array.length-1] The index to search from.
         * @returns {number} Returns the index of the matched value, else `-1`.
         * @example
         *
         * _.lastIndexOf([1, 2, 1, 2], 2);
         * // => 3
         *
         * // Search from the `fromIndex`.
         * _.lastIndexOf([1, 2, 1, 2], 2, 2);
         * // => 1
         */
        function lastIndexOf(array, value, fromIndex) {
            var length = array ? array.length : 0;
            if (!length) {
                return -1;
            }
            var index = length;
            if (fromIndex !== undefined) {
                index = toInteger(fromIndex);
                index = (index < 0 ? nativeMax(length + index, 0) : nativeMin(index, length - 1)) + 1;
            }
            if (value !== value) {
                return indexOfNaN(array, index, true);
            }
            while (index--) {
                if (array[index] === value) {
                    return index;
                }
            }
            return -1;
        }

        /**
         * Removes all given values from `array` using
         * [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * for equality comparisons.
         *
         * **Note:** Unlike `_.without`, this method mutates `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to modify.
         * @param {...*} [values] The values to remove.
         * @returns {Array} Returns `array`.
         * @example
         *
         * var array = [1, 2, 3, 1, 2, 3];
         *
         * _.pull(array, 2, 3);
         * console.log(array);
         * // => [1, 1]
         */
        var pull = rest(pullAll);

        /**
         * This method is like `_.pull` except that it accepts an array of values to remove.
         *
         * **Note:** Unlike `_.difference`, this method mutates `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to modify.
         * @param {Array} values The values to remove.
         * @returns {Array} Returns `array`.
         * @example
         *
         * var array = [1, 2, 3, 1, 2, 3];
         *
         * _.pullAll(array, [2, 3]);
         * console.log(array);
         * // => [1, 1]
         */
        function pullAll(array, values) {
            return (array && array.length && values && values.length)
                ? basePullAll(array, values)
                : array;
        }

        /**
         * This method is like `_.pullAll` except that it accepts `iteratee` which is
         * invoked for each element of `array` and `values` to generate the criterion
         * by which uniqueness is computed. The iteratee is invoked with one argument: (value).
         *
         * **Note:** Unlike `_.differenceBy`, this method mutates `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to modify.
         * @param {Array} values The values to remove.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {Array} Returns `array`.
         * @example
         *
         * var array = [{ 'x': 1 }, { 'x': 2 }, { 'x': 3 }, { 'x': 1 }];
         *
         * _.pullAllBy(array, [{ 'x': 1 }, { 'x': 3 }], 'x');
         * console.log(array);
         * // => [{ 'x': 2 }]
         */
        function pullAllBy(array, values, iteratee) {
            return (array && array.length && values && values.length)
                ? basePullAllBy(array, values, getIteratee(iteratee))
                : array;
        }

        /**
         * Removes elements from `array` corresponding to `indexes` and returns an
         * array of removed elements.
         *
         * **Note:** Unlike `_.at`, this method mutates `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to modify.
         * @param {...(number|number[])} [indexes] The indexes of elements to remove,
         *  specified individually or in arrays.
         * @returns {Array} Returns the new array of removed elements.
         * @example
         *
         * var array = [5, 10, 15, 20];
         * var evens = _.pullAt(array, 1, 3);
         *
         * console.log(array);
         * // => [5, 15]
         *
         * console.log(evens);
         * // => [10, 20]
         */
        var pullAt = rest(function(array, indexes) {
            indexes = arrayMap(baseFlatten(indexes), String);

            var result = baseAt(array, indexes);
            basePullAt(array, indexes.sort(compareAscending));
            return result;
        });

        /**
         * Removes all elements from `array` that `predicate` returns truthy for
         * and returns an array of the removed elements. The predicate is invoked with
         * three arguments: (value, index, array).
         *
         * **Note:** Unlike `_.filter`, this method mutates `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to modify.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the new array of removed elements.
         * @example
         *
         * var array = [1, 2, 3, 4];
         * var evens = _.remove(array, function(n) {
     *   return n % 2 == 0;
     * });
         *
         * console.log(array);
         * // => [1, 3]
         *
         * console.log(evens);
         * // => [2, 4]
         */
        function remove(array, predicate) {
            var result = [];
            if (!(array && array.length)) {
                return result;
            }
            var index = -1,
                indexes = [],
                length = array.length;

            predicate = getIteratee(predicate, 3);
            while (++index < length) {
                var value = array[index];
                if (predicate(value, index, array)) {
                    result.push(value);
                    indexes.push(index);
                }
            }
            basePullAt(array, indexes);
            return result;
        }

        /**
         * Reverses `array` so that the first element becomes the last, the second
         * element becomes the second to last, and so on.
         *
         * **Note:** This method mutates `array` and is based on
         * [`Array#reverse`](https://mdn.io/Array/reverse).
         *
         * @static
         * @memberOf _
         * @category Array
         * @returns {Array} Returns `array`.
         * @example
         *
         * var array = [1, 2, 3];
         *
         * _.reverse(array);
         * // => [3, 2, 1]
         *
         * console.log(array);
         * // => [3, 2, 1]
         */
        function reverse(array) {
            return array ? nativeReverse.call(array) : array;
        }

        /**
         * Creates a slice of `array` from `start` up to, but not including, `end`.
         *
         * **Note:** This method is used instead of [`Array#slice`](https://mdn.io/Array/slice)
         * to ensure dense arrays are returned.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to slice.
         * @param {number} [start=0] The start position.
         * @param {number} [end=array.length] The end position.
         * @returns {Array} Returns the slice of `array`.
         */
        function slice(array, start, end) {
            var length = array ? array.length : 0;
            if (!length) {
                return [];
            }
            if (end && typeof end != 'number' && isIterateeCall(array, start, end)) {
                start = 0;
                end = length;
            }
            else {
                start = start == null ? 0 : toInteger(start);
                end = end === undefined ? length : toInteger(end);
            }
            return baseSlice(array, start, end);
        }

        /**
         * Uses a binary search to determine the lowest index at which `value` should
         * be inserted into `array` in order to maintain its sort order.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The sorted array to inspect.
         * @param {*} value The value to evaluate.
         * @returns {number} Returns the index at which `value` should be inserted into `array`.
         * @example
         *
         * _.sortedIndex([30, 50], 40);
         * // => 1
         *
         * _.sortedIndex([4, 5], 4);
         * // => 0
         */
        function sortedIndex(array, value) {
            return baseSortedIndex(array, value);
        }

        /**
         * This method is like `_.sortedIndex` except that it accepts `iteratee`
         * which is invoked for `value` and each element of `array` to compute their
         * sort ranking. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The sorted array to inspect.
         * @param {*} value The value to evaluate.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {number} Returns the index at which `value` should be inserted into `array`.
         * @example
         *
         * var dict = { 'thirty': 30, 'forty': 40, 'fifty': 50 };
         *
         * _.sortedIndexBy(['thirty', 'fifty'], 'forty', _.propertyOf(dict));
         * // => 1
         *
         * // The `_.property` iteratee shorthand.
         * _.sortedIndexBy([{ 'x': 4 }, { 'x': 5 }], { 'x': 4 }, 'x');
         * // => 0
         */
        function sortedIndexBy(array, value, iteratee) {
            return baseSortedIndexBy(array, value, getIteratee(iteratee));
        }

        /**
         * This method is like `_.indexOf` except that it performs a binary
         * search on a sorted `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to search.
         * @param {*} value The value to search for.
         * @returns {number} Returns the index of the matched value, else `-1`.
         * @example
         *
         * _.sortedIndexOf([1, 1, 2, 2], 2);
         * // => 2
         */
        function sortedIndexOf(array, value) {
            var length = array ? array.length : 0;
            if (length) {
                var index = baseSortedIndex(array, value);
                if (index < length && eq(array[index], value)) {
                    return index;
                }
            }
            return -1;
        }

        /**
         * This method is like `_.sortedIndex` except that it returns the highest
         * index at which `value` should be inserted into `array` in order to
         * maintain its sort order.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The sorted array to inspect.
         * @param {*} value The value to evaluate.
         * @returns {number} Returns the index at which `value` should be inserted into `array`.
         * @example
         *
         * _.sortedLastIndex([4, 5], 4);
         * // => 1
         */
        function sortedLastIndex(array, value) {
            return baseSortedIndex(array, value, true);
        }

        /**
         * This method is like `_.sortedLastIndex` except that it accepts `iteratee`
         * which is invoked for `value` and each element of `array` to compute their
         * sort ranking. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The sorted array to inspect.
         * @param {*} value The value to evaluate.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {number} Returns the index at which `value` should be inserted into `array`.
         * @example
         *
         * // The `_.property` iteratee shorthand.
         * _.sortedLastIndexBy([{ 'x': 4 }, { 'x': 5 }], { 'x': 4 }, 'x');
         * // => 1
         */
        function sortedLastIndexBy(array, value, iteratee) {
            return baseSortedIndexBy(array, value, getIteratee(iteratee), true);
        }

        /**
         * This method is like `_.lastIndexOf` except that it performs a binary
         * search on a sorted `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to search.
         * @param {*} value The value to search for.
         * @returns {number} Returns the index of the matched value, else `-1`.
         * @example
         *
         * _.sortedLastIndexOf([1, 1, 2, 2], 2);
         * // => 3
         */
        function sortedLastIndexOf(array, value) {
            var length = array ? array.length : 0;
            if (length) {
                var index = baseSortedIndex(array, value, true) - 1;
                if (eq(array[index], value)) {
                    return index;
                }
            }
            return -1;
        }

        /**
         * This method is like `_.uniq` except that it's designed and optimized
         * for sorted arrays.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to inspect.
         * @returns {Array} Returns the new duplicate free array.
         * @example
         *
         * _.sortedUniq([1, 1, 2]);
         * // => [1, 2]
         */
        function sortedUniq(array) {
            return (array && array.length)
                ? baseSortedUniq(array)
                : [];
        }

        /**
         * This method is like `_.uniqBy` except that it's designed and optimized
         * for sorted arrays.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to inspect.
         * @param {Function} [iteratee] The iteratee invoked per element.
         * @returns {Array} Returns the new duplicate free array.
         * @example
         *
         * _.sortedUniqBy([1.1, 1.2, 2.3, 2.4], Math.floor);
         * // => [1.1, 2.3]
         */
        function sortedUniqBy(array, iteratee) {
            return (array && array.length)
                ? baseSortedUniqBy(array, getIteratee(iteratee))
                : [];
        }

        /**
         * Gets all but the first element of `array`.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * _.tail([1, 2, 3]);
         * // => [2, 3]
         */
        function tail(array) {
            return drop(array, 1);
        }

        /**
         * Creates a slice of `array` with `n` elements taken from the beginning.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @param {number} [n=1] The number of elements to take.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * _.take([1, 2, 3]);
         * // => [1]
         *
         * _.take([1, 2, 3], 2);
         * // => [1, 2]
         *
         * _.take([1, 2, 3], 5);
         * // => [1, 2, 3]
         *
         * _.take([1, 2, 3], 0);
         * // => []
         */
        function take(array, n, guard) {
            if (!(array && array.length)) {
                return [];
            }
            n = (guard || n === undefined) ? 1 : toInteger(n);
            return baseSlice(array, 0, n < 0 ? 0 : n);
        }

        /**
         * Creates a slice of `array` with `n` elements taken from the end.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @param {number} [n=1] The number of elements to take.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * _.takeRight([1, 2, 3]);
         * // => [3]
         *
         * _.takeRight([1, 2, 3], 2);
         * // => [2, 3]
         *
         * _.takeRight([1, 2, 3], 5);
         * // => [1, 2, 3]
         *
         * _.takeRight([1, 2, 3], 0);
         * // => []
         */
        function takeRight(array, n, guard) {
            var length = array ? array.length : 0;
            if (!length) {
                return [];
            }
            n = (guard || n === undefined) ? 1 : toInteger(n);
            n = length - n;
            return baseSlice(array, n < 0 ? 0 : n, length);
        }

        /**
         * Creates a slice of `array` with elements taken from the end. Elements are
         * taken until `predicate` returns falsey. The predicate is invoked with three
         * arguments: (value, index, array).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'active': true },
         *   { 'user': 'fred',    'active': false },
         *   { 'user': 'pebbles', 'active': false }
         * ];
         *
         * _.takeRightWhile(users, function(o) { return !o.active; });
         * // => objects for ['fred', 'pebbles']
         *
         * // The `_.matches` iteratee shorthand.
         * _.takeRightWhile(users, { 'user': 'pebbles', 'active': false });
         * // => objects for ['pebbles']
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.takeRightWhile(users, ['active', false]);
         * // => objects for ['fred', 'pebbles']
         *
         * // The `_.property` iteratee shorthand.
         * _.takeRightWhile(users, 'active');
         * // => []
         */
        function takeRightWhile(array, predicate) {
            return (array && array.length)
                ? baseWhile(array, getIteratee(predicate, 3), false, true)
                : [];
        }

        /**
         * Creates a slice of `array` with elements taken from the beginning. Elements
         * are taken until `predicate` returns falsey. The predicate is invoked with
         * three arguments: (value, index, array).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to query.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the slice of `array`.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'active': false },
         *   { 'user': 'fred',    'active': false},
         *   { 'user': 'pebbles', 'active': true }
         * ];
         *
         * _.takeWhile(users, function(o) { return !o.active; });
         * // => objects for ['barney', 'fred']
         *
         * // The `_.matches` iteratee shorthand.
         * _.takeWhile(users, { 'user': 'barney', 'active': false });
         * // => objects for ['barney']
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.takeWhile(users, ['active', false]);
         * // => objects for ['barney', 'fred']
         *
         * // The `_.property` iteratee shorthand.
         * _.takeWhile(users, 'active');
         * // => []
         */
        function takeWhile(array, predicate) {
            return (array && array.length)
                ? baseWhile(array, getIteratee(predicate, 3))
                : [];
        }

        /**
         * Creates an array of unique values, in order, from all given arrays using
         * [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * for equality comparisons.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @returns {Array} Returns the new array of combined values.
         * @example
         *
         * _.union([2, 1], [4, 2], [1, 2]);
         * // => [2, 1, 4]
         */
        var union = rest(function(arrays) {
            return baseUniq(baseFlatten(arrays, false, true));
        });

        /**
         * This method is like `_.union` except that it accepts `iteratee` which is
         * invoked for each element of each `arrays` to generate the criterion by which
         * uniqueness is computed. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {Array} Returns the new array of combined values.
         * @example
         *
         * _.unionBy([2.1, 1.2], [4.3, 2.4], Math.floor);
         * // => [2.1, 1.2, 4.3]
         *
         * // The `_.property` iteratee shorthand.
         * _.unionBy([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x');
         * // => [{ 'x': 1 }, { 'x': 2 }]
         */
        var unionBy = rest(function(arrays) {
            var iteratee = last(arrays);
            if (isArrayLikeObject(iteratee)) {
                iteratee = undefined;
            }
            return baseUniq(baseFlatten(arrays, false, true), getIteratee(iteratee));
        });

        /**
         * This method is like `_.union` except that it accepts `comparator` which
         * is invoked to compare elements of `arrays`. The comparator is invoked
         * with two arguments: (arrVal, othVal).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new array of combined values.
         * @example
         *
         * var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }];
         * var others = [{ 'x': 1, 'y': 1 }, { 'x': 1, 'y': 2 }];
         *
         * _.unionWith(objects, others, _.isEqual);
         * // => [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }, { 'x': 1, 'y': 1 }]
         */
        var unionWith = rest(function(arrays) {
            var comparator = last(arrays);
            if (isArrayLikeObject(comparator)) {
                comparator = undefined;
            }
            return baseUniq(baseFlatten(arrays, false, true), undefined, comparator);
        });

        /**
         * Creates a duplicate-free version of an array, using
         * [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * for equality comparisons, in which only the first occurrence of each element
         * is kept.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to inspect.
         * @returns {Array} Returns the new duplicate free array.
         * @example
         *
         * _.uniq([2, 1, 2]);
         * // => [2, 1]
         */
        function uniq(array) {
            return (array && array.length)
                ? baseUniq(array)
                : [];
        }

        /**
         * This method is like `_.uniq` except that it accepts `iteratee` which is
         * invoked for each element in `array` to generate the criterion by which
         * uniqueness is computed. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to inspect.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {Array} Returns the new duplicate free array.
         * @example
         *
         * _.uniqBy([2.1, 1.2, 2.3], Math.floor);
         * // => [2.1, 1.2]
         *
         * // The `_.property` iteratee shorthand.
         * _.uniqBy([{ 'x': 1 }, { 'x': 2 }, { 'x': 1 }], 'x');
         * // => [{ 'x': 1 }, { 'x': 2 }]
         */
        function uniqBy(array, iteratee) {
            return (array && array.length)
                ? baseUniq(array, getIteratee(iteratee))
                : [];
        }

        /**
         * This method is like `_.uniq` except that it accepts `comparator` which
         * is invoked to compare elements of `array`. The comparator is invoked with
         * two arguments: (arrVal, othVal).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to inspect.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new duplicate free array.
         * @example
         *
         * var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 },  { 'x': 1, 'y': 2 }];
         *
         * _.uniqWith(objects, _.isEqual);
         * // => [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
         */
        function uniqWith(array, comparator) {
            return (array && array.length)
                ? baseUniq(array, undefined, comparator)
                : [];
        }

        /**
         * This method is like `_.zip` except that it accepts an array of grouped
         * elements and creates an array regrouping the elements to their pre-zip
         * configuration.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array of grouped elements to process.
         * @returns {Array} Returns the new array of regrouped elements.
         * @example
         *
         * var zipped = _.zip(['fred', 'barney'], [30, 40], [true, false]);
         * // => [['fred', 30, true], ['barney', 40, false]]
         *
         * _.unzip(zipped);
         * // => [['fred', 'barney'], [30, 40], [true, false]]
         */
        function unzip(array) {
            if (!(array && array.length)) {
                return [];
            }
            var length = 0;
            array = arrayFilter(array, function(group) {
                if (isArrayLikeObject(group)) {
                    length = nativeMax(group.length, length);
                    return true;
                }
            });
            return baseTimes(length, function(index) {
                return arrayMap(array, baseProperty(index));
            });
        }

        /**
         * This method is like `_.unzip` except that it accepts `iteratee` to specify
         * how regrouped values should be combined. The iteratee is invoked with the
         * elements of each group: (...group).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array of grouped elements to process.
         * @param {Function} [iteratee=_.identity] The function to combine regrouped values.
         * @returns {Array} Returns the new array of regrouped elements.
         * @example
         *
         * var zipped = _.zip([1, 2], [10, 20], [100, 200]);
         * // => [[1, 10, 100], [2, 20, 200]]
         *
         * _.unzipWith(zipped, _.add);
         * // => [3, 30, 300]
         */
        function unzipWith(array, iteratee) {
            if (!(array && array.length)) {
                return [];
            }
            var result = unzip(array);
            if (iteratee == null) {
                return result;
            }
            return arrayMap(result, function(group) {
                return apply(iteratee, undefined, group);
            });
        }

        /**
         * Creates an array excluding all given values using
         * [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * for equality comparisons.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} array The array to filter.
         * @param {...*} [values] The values to exclude.
         * @returns {Array} Returns the new array of filtered values.
         * @example
         *
         * _.without([1, 2, 1, 3], 1, 2);
         * // => [3]
         */
        var without = rest(function(array, values) {
            return isArrayLikeObject(array)
                ? baseDifference(array, values)
                : [];
        });

        /**
         * Creates an array of unique values that is the [symmetric difference](https://en.wikipedia.org/wiki/Symmetric_difference)
         * of the given arrays.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @returns {Array} Returns the new array of values.
         * @example
         *
         * _.xor([2, 1], [4, 2]);
         * // => [1, 4]
         */
        var xor = rest(function(arrays) {
            return baseXor(arrayFilter(arrays, isArrayLikeObject));
        });

        /**
         * This method is like `_.xor` except that it accepts `iteratee` which is
         * invoked for each element of each `arrays` to generate the criterion by which
         * uniqueness is computed. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {Array} Returns the new array of values.
         * @example
         *
         * _.xorBy([2.1, 1.2], [4.3, 2.4], Math.floor);
         * // => [1.2, 4.3]
         *
         * // The `_.property` iteratee shorthand.
         * _.xorBy([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x');
         * // => [{ 'x': 2 }]
         */
        var xorBy = rest(function(arrays) {
            var iteratee = last(arrays);
            if (isArrayLikeObject(iteratee)) {
                iteratee = undefined;
            }
            return baseXor(arrayFilter(arrays, isArrayLikeObject), getIteratee(iteratee));
        });

        /**
         * This method is like `_.xor` except that it accepts `comparator` which is
         * invoked to compare elements of `arrays`. The comparator is invoked with
         * two arguments: (arrVal, othVal).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to inspect.
         * @param {Function} [comparator] The comparator invoked per element.
         * @returns {Array} Returns the new array of values.
         * @example
         *
         * var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }];
         * var others = [{ 'x': 1, 'y': 1 }, { 'x': 1, 'y': 2 }];
         *
         * _.xorWith(objects, others, _.isEqual);
         * // => [{ 'x': 2, 'y': 1 }, { 'x': 1, 'y': 1 }]
         */
        var xorWith = rest(function(arrays) {
            var comparator = last(arrays);
            if (isArrayLikeObject(comparator)) {
                comparator = undefined;
            }
            return baseXor(arrayFilter(arrays, isArrayLikeObject), undefined, comparator);
        });

        /**
         * Creates an array of grouped elements, the first of which contains the first
         * elements of the given arrays, the second of which contains the second elements
         * of the given arrays, and so on.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to process.
         * @returns {Array} Returns the new array of grouped elements.
         * @example
         *
         * _.zip(['fred', 'barney'], [30, 40], [true, false]);
         * // => [['fred', 30, true], ['barney', 40, false]]
         */
        var zip = rest(unzip);

        /**
         * This method is like `_.fromPairs` except that it accepts two arrays,
         * one of property names and one of corresponding values.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} [props=[]] The property names.
         * @param {Array} [values=[]] The property values.
         * @returns {Object} Returns the new object.
         * @example
         *
         * _.zipObject(['a', 'b'], [1, 2]);
         * // => { 'a': 1, 'b': 2 }
         */
        function zipObject(props, values) {
            return baseZipObject(props || [], values || [], assignValue);
        }

        /**
         * This method is like `_.zipObject` except that it supports property paths.
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {Array} [props=[]] The property names.
         * @param {Array} [values=[]] The property values.
         * @returns {Object} Returns the new object.
         * @example
         *
         * _.zipObjectDeep(['a.b[0].c', 'a.b[1].d'], [1, 2]);
         * // => { 'a': { 'b': [{ 'c': 1 }, { 'd': 2 }] } }
         */
        function zipObjectDeep(props, values) {
            return baseZipObject(props || [], values || [], baseSet);
        }

        /**
         * This method is like `_.zip` except that it accepts `iteratee` to specify
         * how grouped values should be combined. The iteratee is invoked with the
         * elements of each group: (...group).
         *
         * @static
         * @memberOf _
         * @category Array
         * @param {...Array} [arrays] The arrays to process.
         * @param {Function} [iteratee=_.identity] The function to combine grouped values.
         * @returns {Array} Returns the new array of grouped elements.
         * @example
         *
         * _.zipWith([1, 2], [10, 20], [100, 200], function(a, b, c) {
     *   return a + b + c;
     * });
         * // => [111, 222]
         */
        var zipWith = rest(function(arrays) {
            var length = arrays.length,
                iteratee = length > 1 ? arrays[length - 1] : undefined;

            iteratee = typeof iteratee == 'function' ? (arrays.pop(), iteratee) : undefined;
            return unzipWith(arrays, iteratee);
        });

        /*------------------------------------------------------------------------*/

        /**
         * Creates a `lodash` object that wraps `value` with explicit method chaining enabled.
         * The result of such method chaining must be unwrapped with `_#value`.
         *
         * @static
         * @memberOf _
         * @category Seq
         * @param {*} value The value to wrap.
         * @returns {Object} Returns the new `lodash` wrapper instance.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'age': 36 },
         *   { 'user': 'fred',    'age': 40 },
         *   { 'user': 'pebbles', 'age': 1 }
         * ];
         *
         * var youngest = _
         *   .chain(users)
         *   .sortBy('age')
         *   .map(function(o) {
     *     return o.user + ' is ' + o.age;
     *   })
         *   .head()
         *   .value();
         * // => 'pebbles is 1'
         */
        function chain(value) {
            var result = lodash(value);
            result.__chain__ = true;
            return result;
        }

        /**
         * This method invokes `interceptor` and returns `value`. The interceptor
         * is invoked with one argument; (value). The purpose of this method is to
         * "tap into" a method chain in order to modify intermediate results.
         *
         * @static
         * @memberOf _
         * @category Seq
         * @param {*} value The value to provide to `interceptor`.
         * @param {Function} interceptor The function to invoke.
         * @returns {*} Returns `value`.
         * @example
         *
         * _([1, 2, 3])
         *  .tap(function(array) {
     *    // Mutate input array.
     *    array.pop();
     *  })
         *  .reverse()
         *  .value();
         * // => [2, 1]
         */
        function tap(value, interceptor) {
            interceptor(value);
            return value;
        }

        /**
         * This method is like `_.tap` except that it returns the result of `interceptor`.
         * The purpose of this method is to "pass thru" values replacing intermediate
         * results in a method chain.
         *
         * @static
         * @memberOf _
         * @category Seq
         * @param {*} value The value to provide to `interceptor`.
         * @param {Function} interceptor The function to invoke.
         * @returns {*} Returns the result of `interceptor`.
         * @example
         *
         * _('  abc  ')
         *  .chain()
         *  .trim()
         *  .thru(function(value) {
     *    return [value];
     *  })
         *  .value();
         * // => ['abc']
         */
        function thru(value, interceptor) {
            return interceptor(value);
        }

        /**
         * This method is the wrapper version of `_.at`.
         *
         * @name at
         * @memberOf _
         * @category Seq
         * @param {...(string|string[])} [paths] The property paths of elements to pick,
         *  specified individually or in arrays.
         * @returns {Object} Returns the new `lodash` wrapper instance.
         * @example
         *
         * var object = { 'a': [{ 'b': { 'c': 3 } }, 4] };
         *
         * _(object).at(['a[0].b.c', 'a[1]']).value();
         * // => [3, 4]
         *
         * _(['a', 'b', 'c']).at(0, 2).value();
         * // => ['a', 'c']
         */
        var wrapperAt = rest(function(paths) {
            paths = baseFlatten(paths);
            var length = paths.length,
                start = length ? paths[0] : 0,
                value = this.__wrapped__,
                interceptor = function(object) { return baseAt(object, paths); };

            if (length > 1 || this.__actions__.length || !(value instanceof LazyWrapper) || !isIndex(start)) {
                return this.thru(interceptor);
            }
            value = value.slice(start, +start + (length ? 1 : 0));
            value.__actions__.push({ 'func': thru, 'args': [interceptor], 'thisArg': undefined });
            return new LodashWrapper(value, this.__chain__).thru(function(array) {
                if (length && !array.length) {
                    array.push(undefined);
                }
                return array;
            });
        });

        /**
         * Enables explicit method chaining on the wrapper object.
         *
         * @name chain
         * @memberOf _
         * @category Seq
         * @returns {Object} Returns the new `lodash` wrapper instance.
         * @example
         *
         * var users = [
         *   { 'user': 'barney', 'age': 36 },
         *   { 'user': 'fred',   'age': 40 }
         * ];
         *
         * // A sequence without explicit chaining.
         * _(users).head();
         * // => { 'user': 'barney', 'age': 36 }
         *
         * // A sequence with explicit chaining.
         * _(users)
         *   .chain()
         *   .head()
         *   .pick('user')
         *   .value();
         * // => { 'user': 'barney' }
         */
        function wrapperChain() {
            return chain(this);
        }

        /**
         * Executes the chained sequence and returns the wrapped result.
         *
         * @name commit
         * @memberOf _
         * @category Seq
         * @returns {Object} Returns the new `lodash` wrapper instance.
         * @example
         *
         * var array = [1, 2];
         * var wrapped = _(array).push(3);
         *
         * console.log(array);
         * // => [1, 2]
         *
         * wrapped = wrapped.commit();
         * console.log(array);
         * // => [1, 2, 3]
         *
         * wrapped.last();
         * // => 3
         *
         * console.log(array);
         * // => [1, 2, 3]
         */
        function wrapperCommit() {
            return new LodashWrapper(this.value(), this.__chain__);
        }

        /**
         * This method is the wrapper version of `_.flatMap`.
         *
         * @name flatMap
         * @memberOf _
         * @category Seq
         * @param {Function|Object|string} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Object} Returns the new `lodash` wrapper instance.
         * @example
         *
         * function duplicate(n) {
     *   return [n, n];
     * }
         *
         * _([1, 2]).flatMap(duplicate).value();
         * // => [1, 1, 2, 2]
         */
        function wrapperFlatMap(iteratee) {
            return this.map(iteratee).flatten();
        }

        /**
         * Gets the next value on a wrapped object following the
         * [iterator protocol](https://mdn.io/iteration_protocols#iterator).
         *
         * @name next
         * @memberOf _
         * @category Seq
         * @returns {Object} Returns the next iterator value.
         * @example
         *
         * var wrapped = _([1, 2]);
         *
         * wrapped.next();
         * // => { 'done': false, 'value': 1 }
         *
         * wrapped.next();
         * // => { 'done': false, 'value': 2 }
         *
         * wrapped.next();
         * // => { 'done': true, 'value': undefined }
         */
        function wrapperNext() {
            if (this.__values__ === undefined) {
                this.__values__ = toArray(this.value());
            }
            var done = this.__index__ >= this.__values__.length,
                value = done ? undefined : this.__values__[this.__index__++];

            return { 'done': done, 'value': value };
        }

        /**
         * Enables the wrapper to be iterable.
         *
         * @name Symbol.iterator
         * @memberOf _
         * @category Seq
         * @returns {Object} Returns the wrapper object.
         * @example
         *
         * var wrapped = _([1, 2]);
         *
         * wrapped[Symbol.iterator]() === wrapped;
         * // => true
         *
         * Array.from(wrapped);
         * // => [1, 2]
         */
        function wrapperToIterator() {
            return this;
        }

        /**
         * Creates a clone of the chained sequence planting `value` as the wrapped value.
         *
         * @name plant
         * @memberOf _
         * @category Seq
         * @param {*} value The value to plant.
         * @returns {Object} Returns the new `lodash` wrapper instance.
         * @example
         *
         * function square(n) {
     *   return n * n;
     * }
         *
         * var wrapped = _([1, 2]).map(square);
         * var other = wrapped.plant([3, 4]);
         *
         * other.value();
         * // => [9, 16]
         *
         * wrapped.value();
         * // => [1, 4]
         */
        function wrapperPlant(value) {
            var result,
                parent = this;

            while (parent instanceof baseLodash) {
                var clone = wrapperClone(parent);
                clone.__index__ = 0;
                clone.__values__ = undefined;
                if (result) {
                    previous.__wrapped__ = clone;
                } else {
                    result = clone;
                }
                var previous = clone;
                parent = parent.__wrapped__;
            }
            previous.__wrapped__ = value;
            return result;
        }

        /**
         * This method is the wrapper version of `_.reverse`.
         *
         * **Note:** This method mutates the wrapped array.
         *
         * @name reverse
         * @memberOf _
         * @category Seq
         * @returns {Object} Returns the new `lodash` wrapper instance.
         * @example
         *
         * var array = [1, 2, 3];
         *
         * _(array).reverse().value()
         * // => [3, 2, 1]
         *
         * console.log(array);
         * // => [3, 2, 1]
         */
        function wrapperReverse() {
            var value = this.__wrapped__;
            if (value instanceof LazyWrapper) {
                var wrapped = value;
                if (this.__actions__.length) {
                    wrapped = new LazyWrapper(this);
                }
                wrapped = wrapped.reverse();
                wrapped.__actions__.push({ 'func': thru, 'args': [reverse], 'thisArg': undefined });
                return new LodashWrapper(wrapped, this.__chain__);
            }
            return this.thru(reverse);
        }

        /**
         * Executes the chained sequence to extract the unwrapped value.
         *
         * @name value
         * @memberOf _
         * @alias toJSON, valueOf
         * @category Seq
         * @returns {*} Returns the resolved unwrapped value.
         * @example
         *
         * _([1, 2, 3]).value();
         * // => [1, 2, 3]
         */
        function wrapperValue() {
            return baseWrapperValue(this.__wrapped__, this.__actions__);
        }

        /*------------------------------------------------------------------------*/

        /**
         * Creates an object composed of keys generated from the results of running
         * each element of `collection` through `iteratee`. The corresponding value
         * of each key is the number of times the key was returned by `iteratee`.
         * The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee to transform keys.
         * @returns {Object} Returns the composed aggregate object.
         * @example
         *
         * _.countBy([6.1, 4.2, 6.3], Math.floor);
         * // => { '4': 1, '6': 2 }
         *
         * _.countBy(['one', 'two', 'three'], 'length');
         * // => { '3': 2, '5': 1 }
         */
        var countBy = createAggregator(function(result, value, key) {
            hasOwnProperty.call(result, key) ? ++result[key] : (result[key] = 1);
        });

        /**
         * Checks if `predicate` returns truthy for **all** elements of `collection`.
         * Iteration is stopped once `predicate` returns falsey. The predicate is
         * invoked with three arguments: (value, index|key, collection).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {boolean} Returns `true` if all elements pass the predicate check, else `false`.
         * @example
         *
         * _.every([true, 1, null, 'yes'], Boolean);
         * // => false
         *
         * var users = [
         *   { 'user': 'barney', 'active': false },
         *   { 'user': 'fred',   'active': false }
         * ];
         *
         * // The `_.matches` iteratee shorthand.
         * _.every(users, { 'user': 'barney', 'active': false });
         * // => false
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.every(users, ['active', false]);
         * // => true
         *
         * // The `_.property` iteratee shorthand.
         * _.every(users, 'active');
         * // => false
         */
        function every(collection, predicate, guard) {
            var func = isArray(collection) ? arrayEvery : baseEvery;
            if (guard && isIterateeCall(collection, predicate, guard)) {
                predicate = undefined;
            }
            return func(collection, getIteratee(predicate, 3));
        }

        /**
         * Iterates over elements of `collection`, returning an array of all elements
         * `predicate` returns truthy for. The predicate is invoked with three arguments:
         * (value, index|key, collection).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the new filtered array.
         * @example
         *
         * var users = [
         *   { 'user': 'barney', 'age': 36, 'active': true },
         *   { 'user': 'fred',   'age': 40, 'active': false }
         * ];
         *
         * _.filter(users, function(o) { return !o.active; });
         * // => objects for ['fred']
         *
         * // The `_.matches` iteratee shorthand.
         * _.filter(users, { 'age': 36, 'active': true });
         * // => objects for ['barney']
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.filter(users, ['active', false]);
         * // => objects for ['fred']
         *
         * // The `_.property` iteratee shorthand.
         * _.filter(users, 'active');
         * // => objects for ['barney']
         */
        function filter(collection, predicate) {
            var func = isArray(collection) ? arrayFilter : baseFilter;
            return func(collection, getIteratee(predicate, 3));
        }

        /**
         * Iterates over elements of `collection`, returning the first element
         * `predicate` returns truthy for. The predicate is invoked with three arguments:
         * (value, index|key, collection).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to search.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {*} Returns the matched element, else `undefined`.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'age': 36, 'active': true },
         *   { 'user': 'fred',    'age': 40, 'active': false },
         *   { 'user': 'pebbles', 'age': 1,  'active': true }
         * ];
         *
         * _.find(users, function(o) { return o.age < 40; });
         * // => object for 'barney'
         *
         * // The `_.matches` iteratee shorthand.
         * _.find(users, { 'age': 1, 'active': true });
         * // => object for 'pebbles'
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.find(users, ['active', false]);
         * // => object for 'fred'
         *
         * // The `_.property` iteratee shorthand.
         * _.find(users, 'active');
         * // => object for 'barney'
         */
        function find(collection, predicate) {
            predicate = getIteratee(predicate, 3);
            if (isArray(collection)) {
                var index = baseFindIndex(collection, predicate);
                return index > -1 ? collection[index] : undefined;
            }
            return baseFind(collection, predicate, baseEach);
        }

        /**
         * This method is like `_.find` except that it iterates over elements of
         * `collection` from right to left.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to search.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {*} Returns the matched element, else `undefined`.
         * @example
         *
         * _.findLast([1, 2, 3, 4], function(n) {
     *   return n % 2 == 1;
     * });
         * // => 3
         */
        function findLast(collection, predicate) {
            predicate = getIteratee(predicate, 3);
            if (isArray(collection)) {
                var index = baseFindIndex(collection, predicate, true);
                return index > -1 ? collection[index] : undefined;
            }
            return baseFind(collection, predicate, baseEachRight);
        }

        /**
         * Creates an array of flattened values by running each element in `collection`
         * through `iteratee` and concating its result to the other mapped values.
         * The iteratee is invoked with three arguments: (value, index|key, collection).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the new flattened array.
         * @example
         *
         * function duplicate(n) {
     *   return [n, n];
     * }
         *
         * _.flatMap([1, 2], duplicate);
         * // => [1, 1, 2, 2]
         */
        function flatMap(collection, iteratee) {
            return baseFlatten(map(collection, iteratee));
        }

        /**
         * Iterates over elements of `collection` invoking `iteratee` for each element.
         * The iteratee is invoked with three arguments: (value, index|key, collection).
         * Iteratee functions may exit iteration early by explicitly returning `false`.
         *
         * **Note:** As with other "Collections" methods, objects with a "length" property
         * are iterated like arrays. To avoid this behavior use `_.forIn` or `_.forOwn`
         * for object iteration.
         *
         * @static
         * @memberOf _
         * @alias each
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Array|Object} Returns `collection`.
         * @example
         *
         * _([1, 2]).forEach(function(value) {
     *   console.log(value);
     * });
         * // => logs `1` then `2`
         *
         * _.forEach({ 'a': 1, 'b': 2 }, function(value, key) {
     *   console.log(key);
     * });
         * // => logs 'a' then 'b' (iteration order is not guaranteed)
         */
        function forEach(collection, iteratee) {
            return (typeof iteratee == 'function' && isArray(collection))
                ? arrayEach(collection, iteratee)
                : baseEach(collection, toFunction(iteratee));
        }

        /**
         * This method is like `_.forEach` except that it iterates over elements of
         * `collection` from right to left.
         *
         * @static
         * @memberOf _
         * @alias eachRight
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Array|Object} Returns `collection`.
         * @example
         *
         * _.forEachRight([1, 2], function(value) {
     *   console.log(value);
     * });
         * // => logs `2` then `1`
         */
        function forEachRight(collection, iteratee) {
            return (typeof iteratee == 'function' && isArray(collection))
                ? arrayEachRight(collection, iteratee)
                : baseEachRight(collection, toFunction(iteratee));
        }

        /**
         * Creates an object composed of keys generated from the results of running
         * each element of `collection` through `iteratee`. The corresponding value
         * of each key is an array of elements responsible for generating the key.
         * The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee to transform keys.
         * @returns {Object} Returns the composed aggregate object.
         * @example
         *
         * _.groupBy([6.1, 4.2, 6.3], Math.floor);
         * // => { '4': [4.2], '6': [6.1, 6.3] }
         *
         * // The `_.property` iteratee shorthand.
         * _.groupBy(['one', 'two', 'three'], 'length');
         * // => { '3': ['one', 'two'], '5': ['three'] }
         */
        var groupBy = createAggregator(function(result, value, key) {
            if (hasOwnProperty.call(result, key)) {
                result[key].push(value);
            } else {
                result[key] = [value];
            }
        });

        /**
         * Checks if `value` is in `collection`. If `collection` is a string it's checked
         * for a substring of `value`, otherwise [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * is used for equality comparisons. If `fromIndex` is negative, it's used as
         * the offset from the end of `collection`.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object|string} collection The collection to search.
         * @param {*} value The value to search for.
         * @param {number} [fromIndex=0] The index to search from.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.reduce`.
         * @returns {boolean} Returns `true` if `value` is found, else `false`.
         * @example
         *
         * _.includes([1, 2, 3], 1);
         * // => true
         *
         * _.includes([1, 2, 3], 1, 2);
         * // => false
         *
         * _.includes({ 'user': 'fred', 'age': 40 }, 'fred');
         * // => true
         *
         * _.includes('pebbles', 'eb');
         * // => true
         */
        function includes(collection, value, fromIndex, guard) {
            collection = isArrayLike(collection) ? collection : values(collection);
            fromIndex = (fromIndex && !guard) ? toInteger(fromIndex) : 0;

            var length = collection.length;
            if (fromIndex < 0) {
                fromIndex = nativeMax(length + fromIndex, 0);
            }
            return isString(collection)
                ? (fromIndex <= length && collection.indexOf(value, fromIndex) > -1)
                : (!!length && baseIndexOf(collection, value, fromIndex) > -1);
        }

        /**
         * Invokes the method at `path` of each element in `collection`, returning
         * an array of the results of each invoked method. Any additional arguments
         * are provided to each invoked method. If `methodName` is a function it's
         * invoked for, and `this` bound to, each element in `collection`.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Array|Function|string} path The path of the method to invoke or
         *  the function invoked per iteration.
         * @param {...*} [args] The arguments to invoke each method with.
         * @returns {Array} Returns the array of results.
         * @example
         *
         * _.invokeMap([[5, 1, 7], [3, 2, 1]], 'sort');
         * // => [[1, 5, 7], [1, 2, 3]]
         *
         * _.invokeMap([123, 456], String.prototype.split, '');
         * // => [['1', '2', '3'], ['4', '5', '6']]
         */
        var invokeMap = rest(function(collection, path, args) {
            var index = -1,
                isFunc = typeof path == 'function',
                isProp = isKey(path),
                result = isArrayLike(collection) ? Array(collection.length) : [];

            baseEach(collection, function(value) {
                var func = isFunc ? path : ((isProp && value != null) ? value[path] : undefined);
                result[++index] = func ? apply(func, value, args) : baseInvoke(value, path, args);
            });
            return result;
        });

        /**
         * Creates an object composed of keys generated from the results of running
         * each element of `collection` through `iteratee`. The corresponding value
         * of each key is the last element responsible for generating the key. The
         * iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee to transform keys.
         * @returns {Object} Returns the composed aggregate object.
         * @example
         *
         * var array = [
         *   { 'dir': 'left', 'code': 97 },
         *   { 'dir': 'right', 'code': 100 }
         * ];
         *
         * _.keyBy(array, function(o) {
     *   return String.fromCharCode(o.code);
     * });
         * // => { 'a': { 'dir': 'left', 'code': 97 }, 'd': { 'dir': 'right', 'code': 100 } }
         *
         * _.keyBy(array, 'dir');
         * // => { 'left': { 'dir': 'left', 'code': 97 }, 'right': { 'dir': 'right', 'code': 100 } }
         */
        var keyBy = createAggregator(function(result, value, key) {
            result[key] = value;
        });

        /**
         * Creates an array of values by running each element in `collection` through
         * `iteratee`. The iteratee is invoked with three arguments:
         * (value, index|key, collection).
         *
         * Many lodash methods are guarded to work as iteratees for methods like
         * `_.every`, `_.filter`, `_.map`, `_.mapValues`, `_.reject`, and `_.some`.
         *
         * The guarded methods are:
         * `ary`, `curry`, `curryRight`, `drop`, `dropRight`, `every`, `fill`,
         * `invert`, `parseInt`, `random`, `range`, `rangeRight`, `slice`, `some`,
         * `sortBy`, `take`, `takeRight`, `template`, `trim`, `trimEnd`, `trimStart`,
         * and `words`
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the new mapped array.
         * @example
         *
         * function square(n) {
     *   return n * n;
     * }
         *
         * _.map([4, 8], square);
         * // => [16, 64]
         *
         * _.map({ 'a': 4, 'b': 8 }, square);
         * // => [16, 64] (iteration order is not guaranteed)
         *
         * var users = [
         *   { 'user': 'barney' },
         *   { 'user': 'fred' }
         * ];
         *
         * // The `_.property` iteratee shorthand.
         * _.map(users, 'user');
         * // => ['barney', 'fred']
         */
        function map(collection, iteratee) {
            var func = isArray(collection) ? arrayMap : baseMap;
            return func(collection, getIteratee(iteratee, 3));
        }

        /**
         * This method is like `_.sortBy` except that it allows specifying the sort
         * orders of the iteratees to sort by. If `orders` is unspecified, all values
         * are sorted in ascending order. Otherwise, specify an order of "desc" for
         * descending or "asc" for ascending sort order of corresponding values.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function[]|Object[]|string[]} [iteratees=[_.identity]] The iteratees to sort by.
         * @param {string[]} [orders] The sort orders of `iteratees`.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.reduce`.
         * @returns {Array} Returns the new sorted array.
         * @example
         *
         * var users = [
         *   { 'user': 'fred',   'age': 48 },
         *   { 'user': 'barney', 'age': 34 },
         *   { 'user': 'fred',   'age': 42 },
         *   { 'user': 'barney', 'age': 36 }
         * ];
         *
         * // Sort by `user` in ascending order and by `age` in descending order.
         * _.orderBy(users, ['user', 'age'], ['asc', 'desc']);
         * // => objects for [['barney', 36], ['barney', 34], ['fred', 48], ['fred', 42]]
         */
        function orderBy(collection, iteratees, orders, guard) {
            if (collection == null) {
                return [];
            }
            if (!isArray(iteratees)) {
                iteratees = iteratees == null ? [] : [iteratees];
            }
            orders = guard ? undefined : orders;
            if (!isArray(orders)) {
                orders = orders == null ? [] : [orders];
            }
            return baseOrderBy(collection, iteratees, orders);
        }

        /**
         * Creates an array of elements split into two groups, the first of which
         * contains elements `predicate` returns truthy for, the second of which
         * contains elements `predicate` returns falsey for. The predicate is
         * invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the array of grouped elements.
         * @example
         *
         * var users = [
         *   { 'user': 'barney',  'age': 36, 'active': false },
         *   { 'user': 'fred',    'age': 40, 'active': true },
         *   { 'user': 'pebbles', 'age': 1,  'active': false }
         * ];
         *
         * _.partition(users, function(o) { return o.active; });
         * // => objects for [['fred'], ['barney', 'pebbles']]
         *
         * // The `_.matches` iteratee shorthand.
         * _.partition(users, { 'age': 1, 'active': false });
         * // => objects for [['pebbles'], ['barney', 'fred']]
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.partition(users, ['active', false]);
         * // => objects for [['barney', 'pebbles'], ['fred']]
         *
         * // The `_.property` iteratee shorthand.
         * _.partition(users, 'active');
         * // => objects for [['fred'], ['barney', 'pebbles']]
         */
        var partition = createAggregator(function(result, value, key) {
            result[key ? 0 : 1].push(value);
        }, function() { return [[], []]; });

        /**
         * Reduces `collection` to a value which is the accumulated result of running
         * each element in `collection` through `iteratee`, where each successive
         * invocation is supplied the return value of the previous. If `accumulator`
         * is not given the first element of `collection` is used as the initial
         * value. The iteratee is invoked with four arguments:
         * (accumulator, value, index|key, collection).
         *
         * Many lodash methods are guarded to work as iteratees for methods like
         * `_.reduce`, `_.reduceRight`, and `_.transform`.
         *
         * The guarded methods are:
         * `assign`, `defaults`, `defaultsDeep`, `includes`, `merge`, `orderBy`,
         * and `sortBy`
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @param {*} [accumulator] The initial value.
         * @returns {*} Returns the accumulated value.
         * @example
         *
         * _.reduce([1, 2], function(sum, n) {
     *   return sum + n;
     * }, 0);
         * // => 3
         *
         * _.reduce({ 'a': 1, 'b': 2, 'c': 1 }, function(result, value, key) {
     *   (result[value] || (result[value] = [])).push(key);
     *   return result;
     * }, {});
         * // => { '1': ['a', 'c'], '2': ['b'] } (iteration order is not guaranteed)
         */
        function reduce(collection, iteratee, accumulator) {
            var func = isArray(collection) ? arrayReduce : baseReduce,
                initAccum = arguments.length < 3;

            return func(collection, getIteratee(iteratee, 4), accumulator, initAccum, baseEach);
        }

        /**
         * This method is like `_.reduce` except that it iterates over elements of
         * `collection` from right to left.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @param {*} [accumulator] The initial value.
         * @returns {*} Returns the accumulated value.
         * @example
         *
         * var array = [[0, 1], [2, 3], [4, 5]];
         *
         * _.reduceRight(array, function(flattened, other) {
     *   return flattened.concat(other);
     * }, []);
         * // => [4, 5, 2, 3, 0, 1]
         */
        function reduceRight(collection, iteratee, accumulator) {
            var func = isArray(collection) ? arrayReduceRight : baseReduce,
                initAccum = arguments.length < 3;

            return func(collection, getIteratee(iteratee, 4), accumulator, initAccum, baseEachRight);
        }

        /**
         * The opposite of `_.filter`; this method returns the elements of `collection`
         * that `predicate` does **not** return truthy for.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the new filtered array.
         * @example
         *
         * var users = [
         *   { 'user': 'barney', 'age': 36, 'active': false },
         *   { 'user': 'fred',   'age': 40, 'active': true }
         * ];
         *
         * _.reject(users, function(o) { return !o.active; });
         * // => objects for ['fred']
         *
         * // The `_.matches` iteratee shorthand.
         * _.reject(users, { 'age': 40, 'active': true });
         * // => objects for ['barney']
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.reject(users, ['active', false]);
         * // => objects for ['fred']
         *
         * // The `_.property` iteratee shorthand.
         * _.reject(users, 'active');
         * // => objects for ['barney']
         */
        function reject(collection, predicate) {
            var func = isArray(collection) ? arrayFilter : baseFilter;
            predicate = getIteratee(predicate, 3);
            return func(collection, function(value, index, collection) {
                return !predicate(value, index, collection);
            });
        }

        /**
         * Gets a random element from `collection`.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to sample.
         * @returns {*} Returns the random element.
         * @example
         *
         * _.sample([1, 2, 3, 4]);
         * // => 2
         */
        function sample(collection) {
            var array = isArrayLike(collection) ? collection : values(collection),
                length = array.length;

            return length > 0 ? array[baseRandom(0, length - 1)] : undefined;
        }

        /**
         * Gets `n` random elements at unique keys from `collection` up to the
         * size of `collection`.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to sample.
         * @param {number} [n=0] The number of elements to sample.
         * @returns {Array} Returns the random elements.
         * @example
         *
         * _.sampleSize([1, 2, 3], 2);
         * // => [3, 1]
         *
         * _.sampleSize([1, 2, 3], 4);
         * // => [2, 3, 1]
         */
        function sampleSize(collection, n) {
            var index = -1,
                result = toArray(collection),
                length = result.length,
                lastIndex = length - 1;

            n = baseClamp(toInteger(n), 0, length);
            while (++index < n) {
                var rand = baseRandom(index, lastIndex),
                    value = result[rand];

                result[rand] = result[index];
                result[index] = value;
            }
            result.length = n;
            return result;
        }

        /**
         * Creates an array of shuffled values, using a version of the
         * [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher-Yates_shuffle).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to shuffle.
         * @returns {Array} Returns the new shuffled array.
         * @example
         *
         * _.shuffle([1, 2, 3, 4]);
         * // => [4, 1, 3, 2]
         */
        function shuffle(collection) {
            return sampleSize(collection, MAX_ARRAY_LENGTH);
        }

        /**
         * Gets the size of `collection` by returning its length for array-like
         * values or the number of own enumerable properties for objects.
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to inspect.
         * @returns {number} Returns the collection size.
         * @example
         *
         * _.size([1, 2, 3]);
         * // => 3
         *
         * _.size({ 'a': 1, 'b': 2 });
         * // => 2
         *
         * _.size('pebbles');
         * // => 7
         */
        function size(collection) {
            if (collection == null) {
                return 0;
            }
            if (isArrayLike(collection)) {
                var result = collection.length;
                return (result && isString(collection)) ? stringSize(collection) : result;
            }
            return keys(collection).length;
        }

        /**
         * Checks if `predicate` returns truthy for **any** element of `collection`.
         * Iteration is stopped once `predicate` returns truthy. The predicate is
         * invoked with three arguments: (value, index|key, collection).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {boolean} Returns `true` if any element passes the predicate check, else `false`.
         * @example
         *
         * _.some([null, 0, 'yes', false], Boolean);
         * // => true
         *
         * var users = [
         *   { 'user': 'barney', 'active': true },
         *   { 'user': 'fred',   'active': false }
         * ];
         *
         * // The `_.matches` iteratee shorthand.
         * _.some(users, { 'user': 'barney', 'active': false });
         * // => false
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.some(users, ['active', false]);
         * // => true
         *
         * // The `_.property` iteratee shorthand.
         * _.some(users, 'active');
         * // => true
         */
        function some(collection, predicate, guard) {
            var func = isArray(collection) ? arraySome : baseSome;
            if (guard && isIterateeCall(collection, predicate, guard)) {
                predicate = undefined;
            }
            return func(collection, getIteratee(predicate, 3));
        }

        /**
         * Creates an array of elements, sorted in ascending order by the results of
         * running each element in a collection through each iteratee. This method
         * performs a stable sort, that is, it preserves the original sort order of
         * equal elements. The iteratees are invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Collection
         * @param {Array|Object} collection The collection to iterate over.
         * @param {...(Function|Function[]|Object|Object[]|string|string[])} [iteratees=[_.identity]]
         *  The iteratees to sort by, specified individually or in arrays.
         * @returns {Array} Returns the new sorted array.
         * @example
         *
         * var users = [
         *   { 'user': 'fred',   'age': 48 },
         *   { 'user': 'barney', 'age': 36 },
         *   { 'user': 'fred',   'age': 42 },
         *   { 'user': 'barney', 'age': 34 }
         * ];
         *
         * _.sortBy(users, function(o) { return o.user; });
         * // => objects for [['barney', 36], ['barney', 34], ['fred', 48], ['fred', 42]]
         *
         * _.sortBy(users, ['user', 'age']);
         * // => objects for [['barney', 34], ['barney', 36], ['fred', 42], ['fred', 48]]
         *
         * _.sortBy(users, 'user', function(o) {
     *   return Math.floor(o.age / 10);
     * });
         * // => objects for [['barney', 36], ['barney', 34], ['fred', 48], ['fred', 42]]
         */
        var sortBy = rest(function(collection, iteratees) {
            if (collection == null) {
                return [];
            }
            var length = iteratees.length;
            if (length > 1 && isIterateeCall(collection, iteratees[0], iteratees[1])) {
                iteratees = [];
            } else if (length > 2 && isIterateeCall(iteratees[0], iteratees[1], iteratees[2])) {
                iteratees.length = 1;
            }
            return baseOrderBy(collection, baseFlatten(iteratees), []);
        });

        /*------------------------------------------------------------------------*/

        /**
         * Gets the timestamp of the number of milliseconds that have elapsed since
         * the Unix epoch (1 January 1970 00:00:00 UTC).
         *
         * @static
         * @memberOf _
         * @type Function
         * @category Date
         * @returns {number} Returns the timestamp.
         * @example
         *
         * _.defer(function(stamp) {
     *   console.log(_.now() - stamp);
     * }, _.now());
         * // => logs the number of milliseconds it took for the deferred function to be invoked
         */
        var now = Date.now;

        /*------------------------------------------------------------------------*/

        /**
         * The opposite of `_.before`; this method creates a function that invokes
         * `func` once it's called `n` or more times.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {number} n The number of calls before `func` is invoked.
         * @param {Function} func The function to restrict.
         * @returns {Function} Returns the new restricted function.
         * @example
         *
         * var saves = ['profile', 'settings'];
         *
         * var done = _.after(saves.length, function() {
     *   console.log('done saving!');
     * });
         *
         * _.forEach(saves, function(type) {
     *   asyncSave({ 'type': type, 'complete': done });
     * });
         * // => logs 'done saving!' after the two async saves have completed
         */
        function after(n, func) {
            if (typeof func != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            n = toInteger(n);
            return function() {
                if (--n < 1) {
                    return func.apply(this, arguments);
                }
            };
        }

        /**
         * Creates a function that accepts up to `n` arguments, ignoring any
         * additional arguments.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to cap arguments for.
         * @param {number} [n=func.length] The arity cap.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Function} Returns the new function.
         * @example
         *
         * _.map(['6', '8', '10'], _.ary(parseInt, 1));
         * // => [6, 8, 10]
         */
        function ary(func, n, guard) {
            n = guard ? undefined : n;
            n = (func && n == null) ? func.length : n;
            return createWrapper(func, ARY_FLAG, undefined, undefined, undefined, undefined, n);
        }

        /**
         * Creates a function that invokes `func`, with the `this` binding and arguments
         * of the created function, while it's called less than `n` times. Subsequent
         * calls to the created function return the result of the last `func` invocation.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {number} n The number of calls at which `func` is no longer invoked.
         * @param {Function} func The function to restrict.
         * @returns {Function} Returns the new restricted function.
         * @example
         *
         * jQuery(element).on('click', _.before(5, addContactToList));
         * // => allows adding up to 4 contacts to the list
         */
        function before(n, func) {
            var result;
            if (typeof func != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            n = toInteger(n);
            return function() {
                if (--n > 0) {
                    result = func.apply(this, arguments);
                }
                if (n <= 1) {
                    func = undefined;
                }
                return result;
            };
        }

        /**
         * Creates a function that invokes `func` with the `this` binding of `thisArg`
         * and prepends any additional `_.bind` arguments to those provided to the
         * bound function.
         *
         * The `_.bind.placeholder` value, which defaults to `_` in monolithic builds,
         * may be used as a placeholder for partially applied arguments.
         *
         * **Note:** Unlike native `Function#bind` this method doesn't set the "length"
         * property of bound functions.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to bind.
         * @param {*} thisArg The `this` binding of `func`.
         * @param {...*} [partials] The arguments to be partially applied.
         * @returns {Function} Returns the new bound function.
         * @example
         *
         * var greet = function(greeting, punctuation) {
     *   return greeting + ' ' + this.user + punctuation;
     * };
         *
         * var object = { 'user': 'fred' };
         *
         * var bound = _.bind(greet, object, 'hi');
         * bound('!');
         * // => 'hi fred!'
         *
         * // Bound with placeholders.
         * var bound = _.bind(greet, object, _, '!');
         * bound('hi');
         * // => 'hi fred!'
         */
        var bind = rest(function(func, thisArg, partials) {
            var bitmask = BIND_FLAG;
            if (partials.length) {
                var placeholder = lodash.placeholder || bind.placeholder,
                    holders = replaceHolders(partials, placeholder);

                bitmask |= PARTIAL_FLAG;
            }
            return createWrapper(func, bitmask, thisArg, partials, holders);
        });

        /**
         * Creates a function that invokes the method at `object[key]` and prepends
         * any additional `_.bindKey` arguments to those provided to the bound function.
         *
         * This method differs from `_.bind` by allowing bound functions to reference
         * methods that may be redefined or don't yet exist.
         * See [Peter Michaux's article](http://peter.michaux.ca/articles/lazy-function-definition-pattern)
         * for more details.
         *
         * The `_.bindKey.placeholder` value, which defaults to `_` in monolithic
         * builds, may be used as a placeholder for partially applied arguments.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Object} object The object to invoke the method on.
         * @param {string} key The key of the method.
         * @param {...*} [partials] The arguments to be partially applied.
         * @returns {Function} Returns the new bound function.
         * @example
         *
         * var object = {
     *   'user': 'fred',
     *   'greet': function(greeting, punctuation) {
     *     return greeting + ' ' + this.user + punctuation;
     *   }
     * };
         *
         * var bound = _.bindKey(object, 'greet', 'hi');
         * bound('!');
         * // => 'hi fred!'
         *
         * object.greet = function(greeting, punctuation) {
     *   return greeting + 'ya ' + this.user + punctuation;
     * };
         *
         * bound('!');
         * // => 'hiya fred!'
         *
         * // Bound with placeholders.
         * var bound = _.bindKey(object, 'greet', _, '!');
         * bound('hi');
         * // => 'hiya fred!'
         */
        var bindKey = rest(function(object, key, partials) {
            var bitmask = BIND_FLAG | BIND_KEY_FLAG;
            if (partials.length) {
                var placeholder = lodash.placeholder || bindKey.placeholder,
                    holders = replaceHolders(partials, placeholder);

                bitmask |= PARTIAL_FLAG;
            }
            return createWrapper(key, bitmask, object, partials, holders);
        });

        /**
         * Creates a function that accepts arguments of `func` and either invokes
         * `func` returning its result, if at least `arity` number of arguments have
         * been provided, or returns a function that accepts the remaining `func`
         * arguments, and so on. The arity of `func` may be specified if `func.length`
         * is not sufficient.
         *
         * The `_.curry.placeholder` value, which defaults to `_` in monolithic builds,
         * may be used as a placeholder for provided arguments.
         *
         * **Note:** This method doesn't set the "length" property of curried functions.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to curry.
         * @param {number} [arity=func.length] The arity of `func`.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Function} Returns the new curried function.
         * @example
         *
         * var abc = function(a, b, c) {
     *   return [a, b, c];
     * };
         *
         * var curried = _.curry(abc);
         *
         * curried(1)(2)(3);
         * // => [1, 2, 3]
         *
         * curried(1, 2)(3);
         * // => [1, 2, 3]
         *
         * curried(1, 2, 3);
         * // => [1, 2, 3]
         *
         * // Curried with placeholders.
         * curried(1)(_, 3)(2);
         * // => [1, 2, 3]
         */
        function curry(func, arity, guard) {
            arity = guard ? undefined : arity;
            var result = createWrapper(func, CURRY_FLAG, undefined, undefined, undefined, undefined, undefined, arity);
            result.placeholder = lodash.placeholder || curry.placeholder;
            return result;
        }

        /**
         * This method is like `_.curry` except that arguments are applied to `func`
         * in the manner of `_.partialRight` instead of `_.partial`.
         *
         * The `_.curryRight.placeholder` value, which defaults to `_` in monolithic
         * builds, may be used as a placeholder for provided arguments.
         *
         * **Note:** This method doesn't set the "length" property of curried functions.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to curry.
         * @param {number} [arity=func.length] The arity of `func`.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Function} Returns the new curried function.
         * @example
         *
         * var abc = function(a, b, c) {
     *   return [a, b, c];
     * };
         *
         * var curried = _.curryRight(abc);
         *
         * curried(3)(2)(1);
         * // => [1, 2, 3]
         *
         * curried(2, 3)(1);
         * // => [1, 2, 3]
         *
         * curried(1, 2, 3);
         * // => [1, 2, 3]
         *
         * // Curried with placeholders.
         * curried(3)(1, _)(2);
         * // => [1, 2, 3]
         */
        function curryRight(func, arity, guard) {
            arity = guard ? undefined : arity;
            var result = createWrapper(func, CURRY_RIGHT_FLAG, undefined, undefined, undefined, undefined, undefined, arity);
            result.placeholder = lodash.placeholder || curryRight.placeholder;
            return result;
        }

        /**
         * Creates a debounced function that delays invoking `func` until after `wait`
         * milliseconds have elapsed since the last time the debounced function was
         * invoked. The debounced function comes with a `cancel` method to cancel
         * delayed `func` invocations and a `flush` method to immediately invoke them.
         * Provide an options object to indicate whether `func` should be invoked on
         * the leading and/or trailing edge of the `wait` timeout. The `func` is invoked
         * with the last arguments provided to the debounced function. Subsequent calls
         * to the debounced function return the result of the last `func` invocation.
         *
         * **Note:** If `leading` and `trailing` options are `true`, `func` is invoked
         * on the trailing edge of the timeout only if the debounced function is
         * invoked more than once during the `wait` timeout.
         *
         * See [David Corbacho's article](http://drupalmotion.com/article/debounce-and-throttle-visual-explanation)
         * for details over the differences between `_.debounce` and `_.throttle`.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to debounce.
         * @param {number} [wait=0] The number of milliseconds to delay.
         * @param {Object} [options] The options object.
         * @param {boolean} [options.leading=false] Specify invoking on the leading
         *  edge of the timeout.
         * @param {number} [options.maxWait] The maximum time `func` is allowed to be
         *  delayed before it's invoked.
         * @param {boolean} [options.trailing=true] Specify invoking on the trailing
         *  edge of the timeout.
         * @returns {Function} Returns the new debounced function.
         * @example
         *
         * // Avoid costly calculations while the window size is in flux.
         * jQuery(window).on('resize', _.debounce(calculateLayout, 150));
         *
         * // Invoke `sendMail` when clicked, debouncing subsequent calls.
         * jQuery(element).on('click', _.debounce(sendMail, 300, {
     *   'leading': true,
     *   'trailing': false
     * }));
         *
         * // Ensure `batchLog` is invoked once after 1 second of debounced calls.
         * var debounced = _.debounce(batchLog, 250, { 'maxWait': 1000 });
         * var source = new EventSource('/stream');
         * jQuery(source).on('message', debounced);
         *
         * // Cancel the trailing debounced invocation.
         * jQuery(window).on('popstate', debounced.cancel);
         */
        function debounce(func, wait, options) {
            var args,
                maxTimeoutId,
                result,
                stamp,
                thisArg,
                timeoutId,
                trailingCall,
                lastCalled = 0,
                leading = false,
                maxWait = false,
                trailing = true;

            if (typeof func != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            wait = toNumber(wait) || 0;
            if (isObject(options)) {
                leading = !!options.leading;
                maxWait = 'maxWait' in options && nativeMax(toNumber(options.maxWait) || 0, wait);
                trailing = 'trailing' in options ? !!options.trailing : trailing;
            }

            function cancel() {
                if (timeoutId) {
                    clearTimeout(timeoutId);
                }
                if (maxTimeoutId) {
                    clearTimeout(maxTimeoutId);
                }
                lastCalled = 0;
                args = maxTimeoutId = thisArg = timeoutId = trailingCall = undefined;
            }

            function complete(isCalled, id) {
                if (id) {
                    clearTimeout(id);
                }
                maxTimeoutId = timeoutId = trailingCall = undefined;
                if (isCalled) {
                    lastCalled = now();
                    result = func.apply(thisArg, args);
                    if (!timeoutId && !maxTimeoutId) {
                        args = thisArg = undefined;
                    }
                }
            }

            function delayed() {
                var remaining = wait - (now() - stamp);
                if (remaining <= 0 || remaining > wait) {
                    complete(trailingCall, maxTimeoutId);
                } else {
                    timeoutId = setTimeout(delayed, remaining);
                }
            }

            function flush() {
                if ((timeoutId && trailingCall) || (maxTimeoutId && trailing)) {
                    result = func.apply(thisArg, args);
                }
                cancel();
                return result;
            }

            function maxDelayed() {
                complete(trailing, timeoutId);
            }

            function debounced() {
                args = arguments;
                stamp = now();
                thisArg = this;
                trailingCall = trailing && (timeoutId || !leading);

                if (maxWait === false) {
                    var leadingCall = leading && !timeoutId;
                } else {
                    if (!lastCalled && !maxTimeoutId && !leading) {
                        lastCalled = stamp;
                    }
                    var remaining = maxWait - (stamp - lastCalled),
                        isCalled = remaining <= 0 || remaining > maxWait;

                    if (isCalled) {
                        if (maxTimeoutId) {
                            maxTimeoutId = clearTimeout(maxTimeoutId);
                        }
                        lastCalled = stamp;
                        result = func.apply(thisArg, args);
                    }
                    else if (!maxTimeoutId) {
                        maxTimeoutId = setTimeout(maxDelayed, remaining);
                    }
                }
                if (isCalled && timeoutId) {
                    timeoutId = clearTimeout(timeoutId);
                }
                else if (!timeoutId && wait !== maxWait) {
                    timeoutId = setTimeout(delayed, wait);
                }
                if (leadingCall) {
                    isCalled = true;
                    result = func.apply(thisArg, args);
                }
                if (isCalled && !timeoutId && !maxTimeoutId) {
                    args = thisArg = undefined;
                }
                return result;
            }
            debounced.cancel = cancel;
            debounced.flush = flush;
            return debounced;
        }

        /**
         * Defers invoking the `func` until the current call stack has cleared. Any
         * additional arguments are provided to `func` when it's invoked.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to defer.
         * @param {...*} [args] The arguments to invoke `func` with.
         * @returns {number} Returns the timer id.
         * @example
         *
         * _.defer(function(text) {
     *   console.log(text);
     * }, 'deferred');
         * // => logs 'deferred' after one or more milliseconds
         */
        var defer = rest(function(func, args) {
            return baseDelay(func, 1, args);
        });

        /**
         * Invokes `func` after `wait` milliseconds. Any additional arguments are
         * provided to `func` when it's invoked.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to delay.
         * @param {number} wait The number of milliseconds to delay invocation.
         * @param {...*} [args] The arguments to invoke `func` with.
         * @returns {number} Returns the timer id.
         * @example
         *
         * _.delay(function(text) {
     *   console.log(text);
     * }, 1000, 'later');
         * // => logs 'later' after one second
         */
        var delay = rest(function(func, wait, args) {
            return baseDelay(func, toNumber(wait) || 0, args);
        });

        /**
         * Creates a function that invokes `func` with arguments reversed.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to flip arguments for.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var flipped = _.flip(function() {
     *   return _.toArray(arguments);
     * });
         *
         * flipped('a', 'b', 'c', 'd');
         * // => ['d', 'c', 'b', 'a']
         */
        function flip(func) {
            return createWrapper(func, FLIP_FLAG);
        }

        /**
         * Creates a function that memoizes the result of `func`. If `resolver` is
         * provided it determines the cache key for storing the result based on the
         * arguments provided to the memoized function. By default, the first argument
         * provided to the memoized function is used as the map cache key. The `func`
         * is invoked with the `this` binding of the memoized function.
         *
         * **Note:** The cache is exposed as the `cache` property on the memoized
         * function. Its creation may be customized by replacing the `_.memoize.Cache`
         * constructor with one whose instances implement the [`Map`](http://ecma-international.org/ecma-262/6.0/#sec-properties-of-the-map-prototype-object)
         * method interface of `delete`, `get`, `has`, and `set`.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to have its output memoized.
         * @param {Function} [resolver] The function to resolve the cache key.
         * @returns {Function} Returns the new memoizing function.
         * @example
         *
         * var object = { 'a': 1, 'b': 2 };
         * var other = { 'c': 3, 'd': 4 };
         *
         * var values = _.memoize(_.values);
         * values(object);
         * // => [1, 2]
         *
         * values(other);
         * // => [3, 4]
         *
         * object.a = 2;
         * values(object);
         * // => [1, 2]
         *
         * // Modify the result cache.
         * values.cache.set(object, ['a', 'b']);
         * values(object);
         * // => ['a', 'b']
         *
         * // Replace `_.memoize.Cache`.
         * _.memoize.Cache = WeakMap;
         */
        function memoize(func, resolver) {
            if (typeof func != 'function' || (resolver && typeof resolver != 'function')) {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            var memoized = function() {
                var args = arguments,
                    key = resolver ? resolver.apply(this, args) : args[0],
                    cache = memoized.cache;

                if (cache.has(key)) {
                    return cache.get(key);
                }
                var result = func.apply(this, args);
                memoized.cache = cache.set(key, result);
                return result;
            };
            memoized.cache = new memoize.Cache;
            return memoized;
        }

        /**
         * Creates a function that negates the result of the predicate `func`. The
         * `func` predicate is invoked with the `this` binding and arguments of the
         * created function.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} predicate The predicate to negate.
         * @returns {Function} Returns the new function.
         * @example
         *
         * function isEven(n) {
     *   return n % 2 == 0;
     * }
         *
         * _.filter([1, 2, 3, 4, 5, 6], _.negate(isEven));
         * // => [1, 3, 5]
         */
        function negate(predicate) {
            if (typeof predicate != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            return function() {
                return !predicate.apply(this, arguments);
            };
        }

        /**
         * Creates a function that is restricted to invoking `func` once. Repeat calls
         * to the function return the value of the first invocation. The `func` is
         * invoked with the `this` binding and arguments of the created function.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to restrict.
         * @returns {Function} Returns the new restricted function.
         * @example
         *
         * var initialize = _.once(createApplication);
         * initialize();
         * initialize();
         * // `initialize` invokes `createApplication` once
         */
        function once(func) {
            return before(2, func);
        }

        /**
         * Creates a function that invokes `func` with arguments transformed by
         * corresponding `transforms`.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to wrap.
         * @param {...(Function|Function[])} [transforms] The functions to transform
         * arguments, specified individually or in arrays.
         * @returns {Function} Returns the new function.
         * @example
         *
         * function doubled(n) {
     *   return n * 2;
     * }
         *
         * function square(n) {
     *   return n * n;
     * }
         *
         * var func = _.overArgs(function(x, y) {
     *   return [x, y];
     * }, square, doubled);
         *
         * func(9, 3);
         * // => [81, 6]
         *
         * func(10, 5);
         * // => [100, 10]
         */
        var overArgs = rest(function(func, transforms) {
            transforms = arrayMap(baseFlatten(transforms), getIteratee());

            var funcsLength = transforms.length;
            return rest(function(args) {
                var index = -1,
                    length = nativeMin(args.length, funcsLength);

                while (++index < length) {
                    args[index] = transforms[index].call(this, args[index]);
                }
                return apply(func, this, args);
            });
        });

        /**
         * Creates a function that invokes `func` with `partial` arguments prepended
         * to those provided to the new function. This method is like `_.bind` except
         * it does **not** alter the `this` binding.
         *
         * The `_.partial.placeholder` value, which defaults to `_` in monolithic
         * builds, may be used as a placeholder for partially applied arguments.
         *
         * **Note:** This method doesn't set the "length" property of partially
         * applied functions.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to partially apply arguments to.
         * @param {...*} [partials] The arguments to be partially applied.
         * @returns {Function} Returns the new partially applied function.
         * @example
         *
         * var greet = function(greeting, name) {
     *   return greeting + ' ' + name;
     * };
         *
         * var sayHelloTo = _.partial(greet, 'hello');
         * sayHelloTo('fred');
         * // => 'hello fred'
         *
         * // Partially applied with placeholders.
         * var greetFred = _.partial(greet, _, 'fred');
         * greetFred('hi');
         * // => 'hi fred'
         */
        var partial = rest(function(func, partials) {
            var placeholder = lodash.placeholder || partial.placeholder,
                holders = replaceHolders(partials, placeholder);

            return createWrapper(func, PARTIAL_FLAG, undefined, partials, holders);
        });

        /**
         * This method is like `_.partial` except that partially applied arguments
         * are appended to those provided to the new function.
         *
         * The `_.partialRight.placeholder` value, which defaults to `_` in monolithic
         * builds, may be used as a placeholder for partially applied arguments.
         *
         * **Note:** This method doesn't set the "length" property of partially
         * applied functions.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to partially apply arguments to.
         * @param {...*} [partials] The arguments to be partially applied.
         * @returns {Function} Returns the new partially applied function.
         * @example
         *
         * var greet = function(greeting, name) {
     *   return greeting + ' ' + name;
     * };
         *
         * var greetFred = _.partialRight(greet, 'fred');
         * greetFred('hi');
         * // => 'hi fred'
         *
         * // Partially applied with placeholders.
         * var sayHelloTo = _.partialRight(greet, 'hello', _);
         * sayHelloTo('fred');
         * // => 'hello fred'
         */
        var partialRight = rest(function(func, partials) {
            var placeholder = lodash.placeholder || partialRight.placeholder,
                holders = replaceHolders(partials, placeholder);

            return createWrapper(func, PARTIAL_RIGHT_FLAG, undefined, partials, holders);
        });

        /**
         * Creates a function that invokes `func` with arguments arranged according
         * to the specified indexes where the argument value at the first index is
         * provided as the first argument, the argument value at the second index is
         * provided as the second argument, and so on.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to rearrange arguments for.
         * @param {...(number|number[])} indexes The arranged argument indexes,
         *  specified individually or in arrays.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var rearged = _.rearg(function(a, b, c) {
     *   return [a, b, c];
     * }, 2, 0, 1);
         *
         * rearged('b', 'c', 'a')
         * // => ['a', 'b', 'c']
         */
        var rearg = rest(function(func, indexes) {
            return createWrapper(func, REARG_FLAG, undefined, undefined, undefined, baseFlatten(indexes));
        });

        /**
         * Creates a function that invokes `func` with the `this` binding of the
         * created function and arguments from `start` and beyond provided as an array.
         *
         * **Note:** This method is based on the [rest parameter](https://mdn.io/rest_parameters).
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to apply a rest parameter to.
         * @param {number} [start=func.length-1] The start position of the rest parameter.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var say = _.rest(function(what, names) {
     *   return what + ' ' + _.initial(names).join(', ') +
     *     (_.size(names) > 1 ? ', & ' : '') + _.last(names);
     * });
         *
         * say('hello', 'fred', 'barney', 'pebbles');
         * // => 'hello fred, barney, & pebbles'
         */
        function rest(func, start) {
            if (typeof func != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            start = nativeMax(start === undefined ? (func.length - 1) : toInteger(start), 0);
            return function() {
                var args = arguments,
                    index = -1,
                    length = nativeMax(args.length - start, 0),
                    array = Array(length);

                while (++index < length) {
                    array[index] = args[start + index];
                }
                switch (start) {
                    case 0: return func.call(this, array);
                    case 1: return func.call(this, args[0], array);
                    case 2: return func.call(this, args[0], args[1], array);
                }
                var otherArgs = Array(start + 1);
                index = -1;
                while (++index < start) {
                    otherArgs[index] = args[index];
                }
                otherArgs[start] = array;
                return apply(func, this, otherArgs);
            };
        }

        /**
         * Creates a function that invokes `func` with the `this` binding of the created
         * function and an array of arguments much like [`Function#apply`](https://es5.github.io/#x15.3.4.3).
         *
         * **Note:** This method is based on the [spread operator](https://mdn.io/spread_operator).
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to spread arguments over.
         * @param {number} [start=0] The start position of the spread.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var say = _.spread(function(who, what) {
     *   return who + ' says ' + what;
     * });
         *
         * say(['fred', 'hello']);
         * // => 'fred says hello'
         *
         * var numbers = Promise.all([
         *   Promise.resolve(40),
         *   Promise.resolve(36)
         * ]);
         *
         * numbers.then(_.spread(function(x, y) {
     *   return x + y;
     * }));
         * // => a Promise of 76
         */
        function spread(func, start) {
            if (typeof func != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            start = start === undefined ? 0 : nativeMax(toInteger(start), 0);
            return rest(function(args) {
                var array = args[start],
                    otherArgs = args.slice(0, start);

                if (array) {
                    arrayPush(otherArgs, array);
                }
                return apply(func, this, otherArgs);
            });
        }

        /**
         * Creates a throttled function that only invokes `func` at most once per
         * every `wait` milliseconds. The throttled function comes with a `cancel`
         * method to cancel delayed `func` invocations and a `flush` method to
         * immediately invoke them. Provide an options object to indicate whether
         * `func` should be invoked on the leading and/or trailing edge of the `wait`
         * timeout. The `func` is invoked with the last arguments provided to the
         * throttled function. Subsequent calls to the throttled function return the
         * result of the last `func` invocation.
         *
         * **Note:** If `leading` and `trailing` options are `true`, `func` is invoked
         * on the trailing edge of the timeout only if the throttled function is
         * invoked more than once during the `wait` timeout.
         *
         * See [David Corbacho's article](http://drupalmotion.com/article/debounce-and-throttle-visual-explanation)
         * for details over the differences between `_.throttle` and `_.debounce`.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to throttle.
         * @param {number} [wait=0] The number of milliseconds to throttle invocations to.
         * @param {Object} [options] The options object.
         * @param {boolean} [options.leading=true] Specify invoking on the leading
         *  edge of the timeout.
         * @param {boolean} [options.trailing=true] Specify invoking on the trailing
         *  edge of the timeout.
         * @returns {Function} Returns the new throttled function.
         * @example
         *
         * // Avoid excessively updating the position while scrolling.
         * jQuery(window).on('scroll', _.throttle(updatePosition, 100));
         *
         * // Invoke `renewToken` when the click event is fired, but not more than once every 5 minutes.
         * var throttled = _.throttle(renewToken, 300000, { 'trailing': false });
         * jQuery(element).on('click', throttled);
         *
         * // Cancel the trailing throttled invocation.
         * jQuery(window).on('popstate', throttled.cancel);
         */
        function throttle(func, wait, options) {
            var leading = true,
                trailing = true;

            if (typeof func != 'function') {
                throw new TypeError(FUNC_ERROR_TEXT);
            }
            if (isObject(options)) {
                leading = 'leading' in options ? !!options.leading : leading;
                trailing = 'trailing' in options ? !!options.trailing : trailing;
            }
            return debounce(func, wait, { 'leading': leading, 'maxWait': wait, 'trailing': trailing });
        }

        /**
         * Creates a function that accepts up to one argument, ignoring any
         * additional arguments.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {Function} func The function to cap arguments for.
         * @returns {Function} Returns the new function.
         * @example
         *
         * _.map(['6', '8', '10'], _.unary(parseInt));
         * // => [6, 8, 10]
         */
        function unary(func) {
            return ary(func, 1);
        }

        /**
         * Creates a function that provides `value` to the wrapper function as its
         * first argument. Any additional arguments provided to the function are
         * appended to those provided to the wrapper function. The wrapper is invoked
         * with the `this` binding of the created function.
         *
         * @static
         * @memberOf _
         * @category Function
         * @param {*} value The value to wrap.
         * @param {Function} wrapper The wrapper function.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var p = _.wrap(_.escape, function(func, text) {
     *   return '<p>' + func(text) + '</p>';
     * });
         *
         * p('fred, barney, & pebbles');
         * // => '<p>fred, barney, &amp; pebbles</p>'
         */
        function wrap(value, wrapper) {
            wrapper = wrapper == null ? identity : wrapper;
            return partial(wrapper, value);
        }

        /*------------------------------------------------------------------------*/

        /**
         * Creates a shallow clone of `value`.
         *
         * **Note:** This method is loosely based on the
         * [structured clone algorithm](https://mdn.io/Structured_clone_algorithm)
         * and supports cloning arrays, array buffers, booleans, date objects, maps,
         * numbers, `Object` objects, regexes, sets, strings, symbols, and typed
         * arrays. The own enumerable properties of `arguments` objects are cloned
         * as plain objects. An empty object is returned for uncloneable values such
         * as error objects, functions, DOM nodes, and WeakMaps.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to clone.
         * @returns {*} Returns the cloned value.
         * @example
         *
         * var objects = [{ 'a': 1 }, { 'b': 2 }];
         *
         * var shallow = _.clone(objects);
         * console.log(shallow[0] === objects[0]);
         * // => true
         */
        function clone(value) {
            return baseClone(value);
        }

        /**
         * This method is like `_.clone` except that it accepts `customizer` which
         * is invoked to produce the cloned value. If `customizer` returns `undefined`
         * cloning is handled by the method instead. The `customizer` is invoked with
         * up to four arguments; (value [, index|key, object, stack]).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to clone.
         * @param {Function} [customizer] The function to customize cloning.
         * @returns {*} Returns the cloned value.
         * @example
         *
         * function customizer(value) {
     *   if (_.isElement(value)) {
     *     return value.cloneNode(false);
     *   }
     * }
         *
         * var el = _.cloneWith(document.body, customizer);
         *
         * console.log(el === document.body);
         * // => false
         * console.log(el.nodeName);
         * // => 'BODY'
         * console.log(el.childNodes.length);
         * // => 0
         */
        function cloneWith(value, customizer) {
            return baseClone(value, false, customizer);
        }

        /**
         * This method is like `_.clone` except that it recursively clones `value`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to recursively clone.
         * @returns {*} Returns the deep cloned value.
         * @example
         *
         * var objects = [{ 'a': 1 }, { 'b': 2 }];
         *
         * var deep = _.cloneDeep(objects);
         * console.log(deep[0] === objects[0]);
         * // => false
         */
        function cloneDeep(value) {
            return baseClone(value, true);
        }

        /**
         * This method is like `_.cloneWith` except that it recursively clones `value`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to recursively clone.
         * @param {Function} [customizer] The function to customize cloning.
         * @returns {*} Returns the deep cloned value.
         * @example
         *
         * function customizer(value) {
     *   if (_.isElement(value)) {
     *     return value.cloneNode(true);
     *   }
     * }
         *
         * var el = _.cloneDeepWith(document.body, customizer);
         *
         * console.log(el === document.body);
         * // => false
         * console.log(el.nodeName);
         * // => 'BODY'
         * console.log(el.childNodes.length);
         * // => 20
         */
        function cloneDeepWith(value, customizer) {
            return baseClone(value, true, customizer);
        }

        /**
         * Performs a [`SameValueZero`](http://ecma-international.org/ecma-262/6.0/#sec-samevaluezero)
         * comparison between two values to determine if they are equivalent.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to compare.
         * @param {*} other The other value to compare.
         * @returns {boolean} Returns `true` if the values are equivalent, else `false`.
         * @example
         *
         * var object = { 'user': 'fred' };
         * var other = { 'user': 'fred' };
         *
         * _.eq(object, object);
         * // => true
         *
         * _.eq(object, other);
         * // => false
         *
         * _.eq('a', 'a');
         * // => true
         *
         * _.eq('a', Object('a'));
         * // => false
         *
         * _.eq(NaN, NaN);
         * // => true
         */
        function eq(value, other) {
            return value === other || (value !== value && other !== other);
        }

        /**
         * Checks if `value` is greater than `other`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to compare.
         * @param {*} other The other value to compare.
         * @returns {boolean} Returns `true` if `value` is greater than `other`, else `false`.
         * @example
         *
         * _.gt(3, 1);
         * // => true
         *
         * _.gt(3, 3);
         * // => false
         *
         * _.gt(1, 3);
         * // => false
         */
        function gt(value, other) {
            return value > other;
        }

        /**
         * Checks if `value` is greater than or equal to `other`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to compare.
         * @param {*} other The other value to compare.
         * @returns {boolean} Returns `true` if `value` is greater than or equal to `other`, else `false`.
         * @example
         *
         * _.gte(3, 1);
         * // => true
         *
         * _.gte(3, 3);
         * // => true
         *
         * _.gte(1, 3);
         * // => false
         */
        function gte(value, other) {
            return value >= other;
        }

        /**
         * Checks if `value` is likely an `arguments` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isArguments(function() { return arguments; }());
         * // => true
         *
         * _.isArguments([1, 2, 3]);
         * // => false
         */
        function isArguments(value) {
            // Safari 8.1 incorrectly makes `arguments.callee` enumerable in strict mode.
            return isArrayLikeObject(value) && hasOwnProperty.call(value, 'callee') &&
                (!propertyIsEnumerable.call(value, 'callee') || objectToString.call(value) == argsTag);
        }

        /**
         * Checks if `value` is classified as an `Array` object.
         *
         * @static
         * @memberOf _
         * @type Function
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isArray([1, 2, 3]);
         * // => true
         *
         * _.isArray(document.body.children);
         * // => false
         *
         * _.isArray('abc');
         * // => false
         *
         * _.isArray(_.noop);
         * // => false
         */
        var isArray = Array.isArray;

        /**
         * Checks if `value` is classified as an `ArrayBuffer` object.
         *
         * @static
         * @memberOf _
         * @type Function
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isArrayBuffer(new ArrayBuffer(2));
         * // => true
         *
         * _.isArrayBuffer(new Array(2));
         * // => false
         */
        function isArrayBuffer(value) {
            return isObjectLike(value) && objectToString.call(value) == arrayBufferTag;
        }

        /**
         * Checks if `value` is array-like. A value is considered array-like if it's
         * not a function and has a `value.length` that's an integer greater than or
         * equal to `0` and less than or equal to `Number.MAX_SAFE_INTEGER`.
         *
         * @static
         * @memberOf _
         * @type Function
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is array-like, else `false`.
         * @example
         *
         * _.isArrayLike([1, 2, 3]);
         * // => true
         *
         * _.isArrayLike(document.body.children);
         * // => true
         *
         * _.isArrayLike('abc');
         * // => true
         *
         * _.isArrayLike(_.noop);
         * // => false
         */
        function isArrayLike(value) {
            return value != null &&
                !(typeof value == 'function' && isFunction(value)) && isLength(getLength(value));
        }

        /**
         * This method is like `_.isArrayLike` except that it also checks if `value`
         * is an object.
         *
         * @static
         * @memberOf _
         * @type Function
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is an array-like object, else `false`.
         * @example
         *
         * _.isArrayLikeObject([1, 2, 3]);
         * // => true
         *
         * _.isArrayLikeObject(document.body.children);
         * // => true
         *
         * _.isArrayLikeObject('abc');
         * // => false
         *
         * _.isArrayLikeObject(_.noop);
         * // => false
         */
        function isArrayLikeObject(value) {
            return isObjectLike(value) && isArrayLike(value);
        }

        /**
         * Checks if `value` is classified as a boolean primitive or object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isBoolean(false);
         * // => true
         *
         * _.isBoolean(null);
         * // => false
         */
        function isBoolean(value) {
            return value === true || value === false ||
                (isObjectLike(value) && objectToString.call(value) == boolTag);
        }

        /**
         * Checks if `value` is a buffer.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is a buffer, else `false`.
         * @example
         *
         * _.isBuffer(new Buffer(2));
         * // => true
         *
         * _.isBuffer(new Uint8Array(2));
         * // => false
         */
        var isBuffer = !Buffer ? constant(false) : function(value) {
            return value instanceof Buffer;
        };

        /**
         * Checks if `value` is classified as a `Date` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isDate(new Date);
         * // => true
         *
         * _.isDate('Mon April 23 2012');
         * // => false
         */
        function isDate(value) {
            return isObjectLike(value) && objectToString.call(value) == dateTag;
        }

        /**
         * Checks if `value` is likely a DOM element.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is a DOM element, else `false`.
         * @example
         *
         * _.isElement(document.body);
         * // => true
         *
         * _.isElement('<body>');
         * // => false
         */
        function isElement(value) {
            return !!value && value.nodeType === 1 && isObjectLike(value) && !isPlainObject(value);
        }

        /**
         * Checks if `value` is empty. A value is considered empty unless it's an
         * `arguments` object, array, string, or jQuery-like collection with a length
         * greater than `0` or an object with own enumerable properties.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {Array|Object|string} value The value to inspect.
         * @returns {boolean} Returns `true` if `value` is empty, else `false`.
         * @example
         *
         * _.isEmpty(null);
         * // => true
         *
         * _.isEmpty(true);
         * // => true
         *
         * _.isEmpty(1);
         * // => true
         *
         * _.isEmpty([1, 2, 3]);
         * // => false
         *
         * _.isEmpty({ 'a': 1 });
         * // => false
         */
        function isEmpty(value) {
            if (isArrayLike(value) &&
                (isArray(value) || isString(value) || isFunction(value.splice) || isArguments(value))) {
                return !value.length;
            }
            for (var key in value) {
                if (hasOwnProperty.call(value, key)) {
                    return false;
                }
            }
            return true;
        }

        /**
         * Performs a deep comparison between two values to determine if they are
         * equivalent.
         *
         * **Note:** This method supports comparing arrays, array buffers, booleans,
         * date objects, error objects, maps, numbers, `Object` objects, regexes,
         * sets, strings, symbols, and typed arrays. `Object` objects are compared
         * by their own, not inherited, enumerable properties. Functions and DOM
         * nodes are **not** supported.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to compare.
         * @param {*} other The other value to compare.
         * @returns {boolean} Returns `true` if the values are equivalent, else `false`.
         * @example
         *
         * var object = { 'user': 'fred' };
         * var other = { 'user': 'fred' };
         *
         * _.isEqual(object, other);
         * // => true
         *
         * object === other;
         * // => false
         */
        function isEqual(value, other) {
            return baseIsEqual(value, other);
        }

        /**
         * This method is like `_.isEqual` except that it accepts `customizer` which is
         * invoked to compare values. If `customizer` returns `undefined` comparisons are
         * handled by the method instead. The `customizer` is invoked with up to six arguments:
         * (objValue, othValue [, index|key, object, other, stack]).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to compare.
         * @param {*} other The other value to compare.
         * @param {Function} [customizer] The function to customize comparisons.
         * @returns {boolean} Returns `true` if the values are equivalent, else `false`.
         * @example
         *
         * function isGreeting(value) {
     *   return /^h(?:i|ello)$/.test(value);
     * }
         *
         * function customizer(objValue, othValue) {
     *   if (isGreeting(objValue) && isGreeting(othValue)) {
     *     return true;
     *   }
     * }
         *
         * var array = ['hello', 'goodbye'];
         * var other = ['hi', 'goodbye'];
         *
         * _.isEqualWith(array, other, customizer);
         * // => true
         */
        function isEqualWith(value, other, customizer) {
            customizer = typeof customizer == 'function' ? customizer : undefined;
            var result = customizer ? customizer(value, other) : undefined;
            return result === undefined ? baseIsEqual(value, other, customizer) : !!result;
        }

        /**
         * Checks if `value` is an `Error`, `EvalError`, `RangeError`, `ReferenceError`,
         * `SyntaxError`, `TypeError`, or `URIError` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is an error object, else `false`.
         * @example
         *
         * _.isError(new Error);
         * // => true
         *
         * _.isError(Error);
         * // => false
         */
        function isError(value) {
            return isObjectLike(value) &&
                typeof value.message == 'string' && objectToString.call(value) == errorTag;
        }

        /**
         * Checks if `value` is a finite primitive number.
         *
         * **Note:** This method is based on [`Number.isFinite`](https://mdn.io/Number/isFinite).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is a finite number, else `false`.
         * @example
         *
         * _.isFinite(3);
         * // => true
         *
         * _.isFinite(Number.MAX_VALUE);
         * // => true
         *
         * _.isFinite(3.14);
         * // => true
         *
         * _.isFinite(Infinity);
         * // => false
         */
        function isFinite(value) {
            return typeof value == 'number' && nativeIsFinite(value);
        }

        /**
         * Checks if `value` is classified as a `Function` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isFunction(_);
         * // => true
         *
         * _.isFunction(/abc/);
         * // => false
         */
        function isFunction(value) {
            // The use of `Object#toString` avoids issues with the `typeof` operator
            // in Safari 8 which returns 'object' for typed array constructors, and
            // PhantomJS 1.9 which returns 'function' for `NodeList` instances.
            var tag = isObject(value) ? objectToString.call(value) : '';
            return tag == funcTag || tag == genTag;
        }

        /**
         * Checks if `value` is an integer.
         *
         * **Note:** This method is based on [`Number.isInteger`](https://mdn.io/Number/isInteger).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is an integer, else `false`.
         * @example
         *
         * _.isInteger(3);
         * // => true
         *
         * _.isInteger(Number.MIN_VALUE);
         * // => false
         *
         * _.isInteger(Infinity);
         * // => false
         *
         * _.isInteger('3');
         * // => false
         */
        function isInteger(value) {
            return typeof value == 'number' && value == toInteger(value);
        }

        /**
         * Checks if `value` is a valid array-like length.
         *
         * **Note:** This function is loosely based on [`ToLength`](http://ecma-international.org/ecma-262/6.0/#sec-tolength).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is a valid length, else `false`.
         * @example
         *
         * _.isLength(3);
         * // => true
         *
         * _.isLength(Number.MIN_VALUE);
         * // => false
         *
         * _.isLength(Infinity);
         * // => false
         *
         * _.isLength('3');
         * // => false
         */
        function isLength(value) {
            return typeof value == 'number' && value > -1 && value % 1 == 0 && value <= MAX_SAFE_INTEGER;
        }

        /**
         * Checks if `value` is the [language type](https://es5.github.io/#x8) of `Object`.
         * (e.g. arrays, functions, objects, regexes, `new Number(0)`, and `new String('')`)
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is an object, else `false`.
         * @example
         *
         * _.isObject({});
         * // => true
         *
         * _.isObject([1, 2, 3]);
         * // => true
         *
         * _.isObject(_.noop);
         * // => true
         *
         * _.isObject(null);
         * // => false
         */
        function isObject(value) {
            var type = typeof value;
            return !!value && (type == 'object' || type == 'function');
        }

        /**
         * Checks if `value` is object-like. A value is object-like if it's not `null`
         * and has a `typeof` result of "object".
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is object-like, else `false`.
         * @example
         *
         * _.isObjectLike({});
         * // => true
         *
         * _.isObjectLike([1, 2, 3]);
         * // => true
         *
         * _.isObjectLike(_.noop);
         * // => false
         *
         * _.isObjectLike(null);
         * // => false
         */
        function isObjectLike(value) {
            return !!value && typeof value == 'object';
        }

        /**
         * Checks if `value` is classified as a `Map` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isMap(new Map);
         * // => true
         *
         * _.isMap(new WeakMap);
         * // => false
         */
        function isMap(value) {
            return isObjectLike(value) && getTag(value) == mapTag;
        }

        /**
         * Performs a deep comparison between `object` and `source` to determine if
         * `object` contains equivalent property values.
         *
         * **Note:** This method supports comparing the same values as `_.isEqual`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {Object} object The object to inspect.
         * @param {Object} source The object of property values to match.
         * @returns {boolean} Returns `true` if `object` is a match, else `false`.
         * @example
         *
         * var object = { 'user': 'fred', 'age': 40 };
         *
         * _.isMatch(object, { 'age': 40 });
         * // => true
         *
         * _.isMatch(object, { 'age': 36 });
         * // => false
         */
        function isMatch(object, source) {
            return object === source || baseIsMatch(object, source, getMatchData(source));
        }

        /**
         * This method is like `_.isMatch` except that it accepts `customizer` which
         * is invoked to compare values. If `customizer` returns `undefined` comparisons
         * are handled by the method instead. The `customizer` is invoked with five
         * arguments: (objValue, srcValue, index|key, object, source).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {Object} object The object to inspect.
         * @param {Object} source The object of property values to match.
         * @param {Function} [customizer] The function to customize comparisons.
         * @returns {boolean} Returns `true` if `object` is a match, else `false`.
         * @example
         *
         * function isGreeting(value) {
     *   return /^h(?:i|ello)$/.test(value);
     * }
         *
         * function customizer(objValue, srcValue) {
     *   if (isGreeting(objValue) && isGreeting(srcValue)) {
     *     return true;
     *   }
     * }
         *
         * var object = { 'greeting': 'hello' };
         * var source = { 'greeting': 'hi' };
         *
         * _.isMatchWith(object, source, customizer);
         * // => true
         */
        function isMatchWith(object, source, customizer) {
            customizer = typeof customizer == 'function' ? customizer : undefined;
            return baseIsMatch(object, source, getMatchData(source), customizer);
        }

        /**
         * Checks if `value` is `NaN`.
         *
         * **Note:** This method is not the same as [`isNaN`](https://es5.github.io/#x15.1.2.4)
         * which returns `true` for `undefined` and other non-numeric values.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is `NaN`, else `false`.
         * @example
         *
         * _.isNaN(NaN);
         * // => true
         *
         * _.isNaN(new Number(NaN));
         * // => true
         *
         * isNaN(undefined);
         * // => true
         *
         * _.isNaN(undefined);
         * // => false
         */
        function isNaN(value) {
            // An `NaN` primitive is the only value that is not equal to itself.
            // Perform the `toStringTag` check first to avoid errors with some ActiveX objects in IE.
            return isNumber(value) && value != +value;
        }

        /**
         * Checks if `value` is a native function.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is a native function, else `false`.
         * @example
         *
         * _.isNative(Array.prototype.push);
         * // => true
         *
         * _.isNative(_);
         * // => false
         */
        function isNative(value) {
            if (value == null) {
                return false;
            }
            if (isFunction(value)) {
                return reIsNative.test(funcToString.call(value));
            }
            return isObjectLike(value) &&
                (isHostObject(value) ? reIsNative : reIsHostCtor).test(value);
        }

        /**
         * Checks if `value` is `null`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is `null`, else `false`.
         * @example
         *
         * _.isNull(null);
         * // => true
         *
         * _.isNull(void 0);
         * // => false
         */
        function isNull(value) {
            return value === null;
        }

        /**
         * Checks if `value` is `null` or `undefined`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is nullish, else `false`.
         * @example
         *
         * _.isNil(null);
         * // => true
         *
         * _.isNil(void 0);
         * // => true
         *
         * _.isNil(NaN);
         * // => false
         */
        function isNil(value) {
            return value == null;
        }

        /**
         * Checks if `value` is classified as a `Number` primitive or object.
         *
         * **Note:** To exclude `Infinity`, `-Infinity`, and `NaN`, which are classified
         * as numbers, use the `_.isFinite` method.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isNumber(3);
         * // => true
         *
         * _.isNumber(Number.MIN_VALUE);
         * // => true
         *
         * _.isNumber(Infinity);
         * // => true
         *
         * _.isNumber('3');
         * // => false
         */
        function isNumber(value) {
            return typeof value == 'number' ||
                (isObjectLike(value) && objectToString.call(value) == numberTag);
        }

        /**
         * Checks if `value` is a plain object, that is, an object created by the
         * `Object` constructor or one with a `[[Prototype]]` of `null`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is a plain object, else `false`.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     * }
         *
         * _.isPlainObject(new Foo);
         * // => false
         *
         * _.isPlainObject([1, 2, 3]);
         * // => false
         *
         * _.isPlainObject({ 'x': 0, 'y': 0 });
         * // => true
         *
         * _.isPlainObject(Object.create(null));
         * // => true
         */
        function isPlainObject(value) {
            if (!isObjectLike(value) || objectToString.call(value) != objectTag || isHostObject(value)) {
                return false;
            }
            var proto = objectProto;
            if (typeof value.constructor == 'function') {
                proto = getPrototypeOf(value);
            }
            if (proto === null) {
                return true;
            }
            var Ctor = proto.constructor;
            return (typeof Ctor == 'function' &&
            Ctor instanceof Ctor && funcToString.call(Ctor) == objectCtorString);
        }

        /**
         * Checks if `value` is classified as a `RegExp` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isRegExp(/abc/);
         * // => true
         *
         * _.isRegExp('/abc/');
         * // => false
         */
        function isRegExp(value) {
            return isObject(value) && objectToString.call(value) == regexpTag;
        }

        /**
         * Checks if `value` is a safe integer. An integer is safe if it's an IEEE-754
         * double precision number which isn't the result of a rounded unsafe integer.
         *
         * **Note:** This method is based on [`Number.isSafeInteger`](https://mdn.io/Number/isSafeInteger).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is a safe integer, else `false`.
         * @example
         *
         * _.isSafeInteger(3);
         * // => true
         *
         * _.isSafeInteger(Number.MIN_VALUE);
         * // => false
         *
         * _.isSafeInteger(Infinity);
         * // => false
         *
         * _.isSafeInteger('3');
         * // => false
         */
        function isSafeInteger(value) {
            return isInteger(value) && value >= -MAX_SAFE_INTEGER && value <= MAX_SAFE_INTEGER;
        }

        /**
         * Checks if `value` is classified as a `Set` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isSet(new Set);
         * // => true
         *
         * _.isSet(new WeakSet);
         * // => false
         */
        function isSet(value) {
            return isObjectLike(value) && getTag(value) == setTag;
        }

        /**
         * Checks if `value` is classified as a `String` primitive or object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isString('abc');
         * // => true
         *
         * _.isString(1);
         * // => false
         */
        function isString(value) {
            return typeof value == 'string' ||
                (!isArray(value) && isObjectLike(value) && objectToString.call(value) == stringTag);
        }

        /**
         * Checks if `value` is classified as a `Symbol` primitive or object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isSymbol(Symbol.iterator);
         * // => true
         *
         * _.isSymbol('abc');
         * // => false
         */
        function isSymbol(value) {
            return typeof value == 'symbol' ||
                (isObjectLike(value) && objectToString.call(value) == symbolTag);
        }

        /**
         * Checks if `value` is classified as a typed array.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isTypedArray(new Uint8Array);
         * // => true
         *
         * _.isTypedArray([]);
         * // => false
         */
        function isTypedArray(value) {
            return isObjectLike(value) && isLength(value.length) && !!typedArrayTags[objectToString.call(value)];
        }

        /**
         * Checks if `value` is `undefined`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is `undefined`, else `false`.
         * @example
         *
         * _.isUndefined(void 0);
         * // => true
         *
         * _.isUndefined(null);
         * // => false
         */
        function isUndefined(value) {
            return value === undefined;
        }

        /**
         * Checks if `value` is classified as a `WeakMap` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isWeakMap(new WeakMap);
         * // => true
         *
         * _.isWeakMap(new Map);
         * // => false
         */
        function isWeakMap(value) {
            return isObjectLike(value) && getTag(value) == weakMapTag;
        }

        /**
         * Checks if `value` is classified as a `WeakSet` object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to check.
         * @returns {boolean} Returns `true` if `value` is correctly classified, else `false`.
         * @example
         *
         * _.isWeakSet(new WeakSet);
         * // => true
         *
         * _.isWeakSet(new Set);
         * // => false
         */
        function isWeakSet(value) {
            return isObjectLike(value) && objectToString.call(value) == weakSetTag;
        }

        /**
         * Checks if `value` is less than `other`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to compare.
         * @param {*} other The other value to compare.
         * @returns {boolean} Returns `true` if `value` is less than `other`, else `false`.
         * @example
         *
         * _.lt(1, 3);
         * // => true
         *
         * _.lt(3, 3);
         * // => false
         *
         * _.lt(3, 1);
         * // => false
         */
        function lt(value, other) {
            return value < other;
        }

        /**
         * Checks if `value` is less than or equal to `other`.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to compare.
         * @param {*} other The other value to compare.
         * @returns {boolean} Returns `true` if `value` is less than or equal to `other`, else `false`.
         * @example
         *
         * _.lte(1, 3);
         * // => true
         *
         * _.lte(3, 3);
         * // => true
         *
         * _.lte(3, 1);
         * // => false
         */
        function lte(value, other) {
            return value <= other;
        }

        /**
         * Converts `value` to an array.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to convert.
         * @returns {Array} Returns the converted array.
         * @example
         *
         * _.toArray({ 'a': 1, 'b': 2 });
         * // => [1, 2]
         *
         * _.toArray('abc');
         * // => ['a', 'b', 'c']
         *
         * _.toArray(1);
         * // => []
         *
         * _.toArray(null);
         * // => []
         */
        function toArray(value) {
            if (!value) {
                return [];
            }
            if (isArrayLike(value)) {
                return isString(value) ? stringToArray(value) : copyArray(value);
            }
            if (iteratorSymbol && value[iteratorSymbol]) {
                return iteratorToArray(value[iteratorSymbol]());
            }
            var tag = getTag(value),
                func = tag == mapTag ? mapToArray : (tag == setTag ? setToArray : values);

            return func(value);
        }

        /**
         * Converts `value` to an integer.
         *
         * **Note:** This function is loosely based on [`ToInteger`](http://www.ecma-international.org/ecma-262/6.0/#sec-tointeger).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to convert.
         * @returns {number} Returns the converted integer.
         * @example
         *
         * _.toInteger(3);
         * // => 3
         *
         * _.toInteger(Number.MIN_VALUE);
         * // => 0
         *
         * _.toInteger(Infinity);
         * // => 1.7976931348623157e+308
         *
         * _.toInteger('3');
         * // => 3
         */
        function toInteger(value) {
            if (!value) {
                return value === 0 ? value : 0;
            }
            value = toNumber(value);
            if (value === INFINITY || value === -INFINITY) {
                var sign = (value < 0 ? -1 : 1);
                return sign * MAX_INTEGER;
            }
            var remainder = value % 1;
            return value === value ? (remainder ? value - remainder : value) : 0;
        }

        /**
         * Converts `value` to an integer suitable for use as the length of an
         * array-like object.
         *
         * **Note:** This method is based on [`ToLength`](http://ecma-international.org/ecma-262/6.0/#sec-tolength).
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to convert.
         * @returns {number} Returns the converted integer.
         * @example
         *
         * _.toLength(3);
         * // => 3
         *
         * _.toLength(Number.MIN_VALUE);
         * // => 0
         *
         * _.toLength(Infinity);
         * // => 4294967295
         *
         * _.toLength('3');
         * // => 3
         */
        function toLength(value) {
            return value ? baseClamp(toInteger(value), 0, MAX_ARRAY_LENGTH) : 0;
        }

        /**
         * Converts `value` to a number.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to process.
         * @returns {number} Returns the number.
         * @example
         *
         * _.toNumber(3);
         * // => 3
         *
         * _.toNumber(Number.MIN_VALUE);
         * // => 5e-324
         *
         * _.toNumber(Infinity);
         * // => Infinity
         *
         * _.toNumber('3');
         * // => 3
         */
        function toNumber(value) {
            if (isObject(value)) {
                var other = isFunction(value.valueOf) ? value.valueOf() : value;
                value = isObject(other) ? (other + '') : other;
            }
            if (typeof value != 'string') {
                return value === 0 ? value : +value;
            }
            value = value.replace(reTrim, '');
            var isBinary = reIsBinary.test(value);
            return (isBinary || reIsOctal.test(value))
                ? freeParseInt(value.slice(2), isBinary ? 2 : 8)
                : (reIsBadHex.test(value) ? NAN : +value);
        }

        /**
         * Converts `value` to a plain object flattening inherited enumerable
         * properties of `value` to own properties of the plain object.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to convert.
         * @returns {Object} Returns the converted plain object.
         * @example
         *
         * function Foo() {
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.assign({ 'a': 1 }, new Foo);
         * // => { 'a': 1, 'b': 2 }
         *
         * _.assign({ 'a': 1 }, _.toPlainObject(new Foo));
         * // => { 'a': 1, 'b': 2, 'c': 3 }
         */
        function toPlainObject(value) {
            return copyObject(value, keysIn(value));
        }

        /**
         * Converts `value` to a safe integer. A safe integer can be compared and
         * represented correctly.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to convert.
         * @returns {number} Returns the converted integer.
         * @example
         *
         * _.toSafeInteger(3);
         * // => 3
         *
         * _.toSafeInteger(Number.MIN_VALUE);
         * // => 0
         *
         * _.toSafeInteger(Infinity);
         * // => 9007199254740991
         *
         * _.toSafeInteger('3');
         * // => 3
         */
        function toSafeInteger(value) {
            return baseClamp(toInteger(value), -MAX_SAFE_INTEGER, MAX_SAFE_INTEGER);
        }

        /**
         * Converts `value` to a string if it's not one. An empty string is returned
         * for `null` and `undefined` values. The sign of `-0` is preserved.
         *
         * @static
         * @memberOf _
         * @category Lang
         * @param {*} value The value to process.
         * @returns {string} Returns the string.
         * @example
         *
         * _.toString(null);
         * // => ''
         *
         * _.toString(-0);
         * // => '-0'
         *
         * _.toString([1, 2, 3]);
         * // => '1,2,3'
         */
        function toString(value) {
            // Exit early for strings to avoid a performance hit in some environments.
            if (typeof value == 'string') {
                return value;
            }
            if (value == null) {
                return '';
            }
            if (isSymbol(value)) {
                return Symbol ? symbolToString.call(value) : '';
            }
            var result = (value + '');
            return (result == '0' && (1 / value) == -INFINITY) ? '-0' : result;
        }

        /*------------------------------------------------------------------------*/

        /**
         * Assigns own enumerable properties of source objects to the destination
         * object. Source objects are applied from left to right. Subsequent sources
         * overwrite property assignments of previous sources.
         *
         * **Note:** This method mutates `object` and is loosely based on
         * [`Object.assign`](https://mdn.io/Object/assign).
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The destination object.
         * @param {...Object} [sources] The source objects.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function Foo() {
     *   this.c = 3;
     * }
         *
         * function Bar() {
     *   this.e = 5;
     * }
         *
         * Foo.prototype.d = 4;
         * Bar.prototype.f = 6;
         *
         * _.assign({ 'a': 1 }, new Foo, new Bar);
         * // => { 'a': 1, 'c': 3, 'e': 5 }
         */
        var assign = createAssigner(function(object, source) {
            copyObject(source, keys(source), object);
        });

        /**
         * This method is like `_.assign` except that it iterates over own and
         * inherited source properties.
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @alias extend
         * @category Object
         * @param {Object} object The destination object.
         * @param {...Object} [sources] The source objects.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function Foo() {
     *   this.b = 2;
     * }
         *
         * function Bar() {
     *   this.d = 4;
     * }
         *
         * Foo.prototype.c = 3;
         * Bar.prototype.e = 5;
         *
         * _.assignIn({ 'a': 1 }, new Foo, new Bar);
         * // => { 'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5 }
         */
        var assignIn = createAssigner(function(object, source) {
            copyObject(source, keysIn(source), object);
        });

        /**
         * This method is like `_.assignIn` except that it accepts `customizer` which
         * is invoked to produce the assigned values. If `customizer` returns `undefined`
         * assignment is handled by the method instead. The `customizer` is invoked
         * with five arguments: (objValue, srcValue, key, object, source).
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @alias extendWith
         * @category Object
         * @param {Object} object The destination object.
         * @param {...Object} sources The source objects.
         * @param {Function} [customizer] The function to customize assigned values.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function customizer(objValue, srcValue) {
     *   return _.isUndefined(objValue) ? srcValue : objValue;
     * }
         *
         * var defaults = _.partialRight(_.assignInWith, customizer);
         *
         * defaults({ 'a': 1 }, { 'b': 2 }, { 'a': 3 });
         * // => { 'a': 1, 'b': 2 }
         */
        var assignInWith = createAssigner(function(object, source, srcIndex, customizer) {
            copyObjectWith(source, keysIn(source), object, customizer);
        });

        /**
         * This method is like `_.assign` except that it accepts `customizer` which
         * is invoked to produce the assigned values. If `customizer` returns `undefined`
         * assignment is handled by the method instead. The `customizer` is invoked
         * with five arguments: (objValue, srcValue, key, object, source).
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The destination object.
         * @param {...Object} sources The source objects.
         * @param {Function} [customizer] The function to customize assigned values.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function customizer(objValue, srcValue) {
     *   return _.isUndefined(objValue) ? srcValue : objValue;
     * }
         *
         * var defaults = _.partialRight(_.assignWith, customizer);
         *
         * defaults({ 'a': 1 }, { 'b': 2 }, { 'a': 3 });
         * // => { 'a': 1, 'b': 2 }
         */
        var assignWith = createAssigner(function(object, source, srcIndex, customizer) {
            copyObjectWith(source, keys(source), object, customizer);
        });

        /**
         * Creates an array of values corresponding to `paths` of `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to iterate over.
         * @param {...(string|string[])} [paths] The property paths of elements to pick,
         *  specified individually or in arrays.
         * @returns {Array} Returns the new array of picked elements.
         * @example
         *
         * var object = { 'a': [{ 'b': { 'c': 3 } }, 4] };
         *
         * _.at(object, ['a[0].b.c', 'a[1]']);
         * // => [3, 4]
         *
         * _.at(['a', 'b', 'c'], 0, 2);
         * // => ['a', 'c']
         */
        var at = rest(function(object, paths) {
            return baseAt(object, baseFlatten(paths));
        });

        /**
         * Creates an object that inherits from the `prototype` object. If a `properties`
         * object is given its own enumerable properties are assigned to the created object.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} prototype The object to inherit from.
         * @param {Object} [properties] The properties to assign to the object.
         * @returns {Object} Returns the new object.
         * @example
         *
         * function Shape() {
     *   this.x = 0;
     *   this.y = 0;
     * }
         *
         * function Circle() {
     *   Shape.call(this);
     * }
         *
         * Circle.prototype = _.create(Shape.prototype, {
     *   'constructor': Circle
     * });
         *
         * var circle = new Circle;
         * circle instanceof Circle;
         * // => true
         *
         * circle instanceof Shape;
         * // => true
         */
        function create(prototype, properties) {
            var result = baseCreate(prototype);
            return properties ? baseAssign(result, properties) : result;
        }

        /**
         * Assigns own and inherited enumerable properties of source objects to the
         * destination object for all destination properties that resolve to `undefined`.
         * Source objects are applied from left to right. Once a property is set,
         * additional values of the same property are ignored.
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The destination object.
         * @param {...Object} [sources] The source objects.
         * @returns {Object} Returns `object`.
         * @example
         *
         * _.defaults({ 'user': 'barney' }, { 'age': 36 }, { 'user': 'fred' });
         * // => { 'user': 'barney', 'age': 36 }
         */
        var defaults = rest(function(args) {
            args.push(undefined, assignInDefaults);
            return apply(assignInWith, undefined, args);
        });

        /**
         * This method is like `_.defaults` except that it recursively assigns
         * default properties.
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The destination object.
         * @param {...Object} [sources] The source objects.
         * @returns {Object} Returns `object`.
         * @example
         *
         * _.defaultsDeep({ 'user': { 'name': 'barney' } }, { 'user': { 'name': 'fred', 'age': 36 } });
         * // => { 'user': { 'name': 'barney', 'age': 36 } }
         *
         */
        var defaultsDeep = rest(function(args) {
            args.push(undefined, mergeDefaults);
            return apply(mergeWith, undefined, args);
        });

        /**
         * This method is like `_.find` except that it returns the key of the first
         * element `predicate` returns truthy for instead of the element itself.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to search.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {string|undefined} Returns the key of the matched element, else `undefined`.
         * @example
         *
         * var users = {
     *   'barney':  { 'age': 36, 'active': true },
     *   'fred':    { 'age': 40, 'active': false },
     *   'pebbles': { 'age': 1,  'active': true }
     * };
         *
         * _.findKey(users, function(o) { return o.age < 40; });
         * // => 'barney' (iteration order is not guaranteed)
         *
         * // The `_.matches` iteratee shorthand.
         * _.findKey(users, { 'age': 1, 'active': true });
         * // => 'pebbles'
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.findKey(users, ['active', false]);
         * // => 'fred'
         *
         * // The `_.property` iteratee shorthand.
         * _.findKey(users, 'active');
         * // => 'barney'
         */
        function findKey(object, predicate) {
            return baseFind(object, getIteratee(predicate, 3), baseForOwn, true);
        }

        /**
         * This method is like `_.findKey` except that it iterates over elements of
         * a collection in the opposite order.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to search.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per iteration.
         * @returns {string|undefined} Returns the key of the matched element, else `undefined`.
         * @example
         *
         * var users = {
     *   'barney':  { 'age': 36, 'active': true },
     *   'fred':    { 'age': 40, 'active': false },
     *   'pebbles': { 'age': 1,  'active': true }
     * };
         *
         * _.findLastKey(users, function(o) { return o.age < 40; });
         * // => returns 'pebbles' assuming `_.findKey` returns 'barney'
         *
         * // The `_.matches` iteratee shorthand.
         * _.findLastKey(users, { 'age': 36, 'active': true });
         * // => 'barney'
         *
         * // The `_.matchesProperty` iteratee shorthand.
         * _.findLastKey(users, ['active', false]);
         * // => 'fred'
         *
         * // The `_.property` iteratee shorthand.
         * _.findLastKey(users, 'active');
         * // => 'pebbles'
         */
        function findLastKey(object, predicate) {
            return baseFind(object, getIteratee(predicate, 3), baseForOwnRight, true);
        }

        /**
         * Iterates over own and inherited enumerable properties of an object invoking
         * `iteratee` for each property. The iteratee is invoked with three arguments:
         * (value, key, object). Iteratee functions may exit iteration early by explicitly
         * returning `false`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.forIn(new Foo, function(value, key) {
     *   console.log(key);
     * });
         * // => logs 'a', 'b', then 'c' (iteration order is not guaranteed)
         */
        function forIn(object, iteratee) {
            return object == null ? object : baseFor(object, toFunction(iteratee), keysIn);
        }

        /**
         * This method is like `_.forIn` except that it iterates over properties of
         * `object` in the opposite order.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.forInRight(new Foo, function(value, key) {
     *   console.log(key);
     * });
         * // => logs 'c', 'b', then 'a' assuming `_.forIn` logs 'a', 'b', then 'c'
         */
        function forInRight(object, iteratee) {
            return object == null ? object : baseForRight(object, toFunction(iteratee), keysIn);
        }

        /**
         * Iterates over own enumerable properties of an object invoking `iteratee`
         * for each property. The iteratee is invoked with three arguments:
         * (value, key, object). Iteratee functions may exit iteration early by
         * explicitly returning `false`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.forOwn(new Foo, function(value, key) {
     *   console.log(key);
     * });
         * // => logs 'a' then 'b' (iteration order is not guaranteed)
         */
        function forOwn(object, iteratee) {
            return object && baseForOwn(object, toFunction(iteratee));
        }

        /**
         * This method is like `_.forOwn` except that it iterates over properties of
         * `object` in the opposite order.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.forOwnRight(new Foo, function(value, key) {
     *   console.log(key);
     * });
         * // => logs 'b' then 'a' assuming `_.forOwn` logs 'a' then 'b'
         */
        function forOwnRight(object, iteratee) {
            return object && baseForOwnRight(object, toFunction(iteratee));
        }

        /**
         * Creates an array of function property names from own enumerable properties
         * of `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to inspect.
         * @returns {Array} Returns the new array of property names.
         * @example
         *
         * function Foo() {
     *   this.a = _.constant('a');
     *   this.b = _.constant('b');
     * }
         *
         * Foo.prototype.c = _.constant('c');
         *
         * _.functions(new Foo);
         * // => ['a', 'b']
         */
        function functions(object) {
            return object == null ? [] : baseFunctions(object, keys(object));
        }

        /**
         * Creates an array of function property names from own and inherited
         * enumerable properties of `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to inspect.
         * @returns {Array} Returns the new array of property names.
         * @example
         *
         * function Foo() {
     *   this.a = _.constant('a');
     *   this.b = _.constant('b');
     * }
         *
         * Foo.prototype.c = _.constant('c');
         *
         * _.functionsIn(new Foo);
         * // => ['a', 'b', 'c']
         */
        function functionsIn(object) {
            return object == null ? [] : baseFunctions(object, keysIn(object));
        }

        /**
         * Gets the value at `path` of `object`. If the resolved value is
         * `undefined` the `defaultValue` is used in its place.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @param {Array|string} path The path of the property to get.
         * @param {*} [defaultValue] The value returned if the resolved value is `undefined`.
         * @returns {*} Returns the resolved value.
         * @example
         *
         * var object = { 'a': [{ 'b': { 'c': 3 } }] };
         *
         * _.get(object, 'a[0].b.c');
         * // => 3
         *
         * _.get(object, ['a', '0', 'b', 'c']);
         * // => 3
         *
         * _.get(object, 'a.b.c', 'default');
         * // => 'default'
         */
        function get(object, path, defaultValue) {
            var result = object == null ? undefined : baseGet(object, path);
            return result === undefined ? defaultValue : result;
        }

        /**
         * Checks if `path` is a direct property of `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @param {Array|string} path The path to check.
         * @returns {boolean} Returns `true` if `path` exists, else `false`.
         * @example
         *
         * var object = { 'a': { 'b': { 'c': 3 } } };
         * var other = _.create({ 'a': _.create({ 'b': _.create({ 'c': 3 }) }) });
         *
         * _.has(object, 'a');
         * // => true
         *
         * _.has(object, 'a.b.c');
         * // => true
         *
         * _.has(object, ['a', 'b', 'c']);
         * // => true
         *
         * _.has(other, 'a');
         * // => false
         */
        function has(object, path) {
            return hasPath(object, path, baseHas);
        }

        /**
         * Checks if `path` is a direct or inherited property of `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @param {Array|string} path The path to check.
         * @returns {boolean} Returns `true` if `path` exists, else `false`.
         * @example
         *
         * var object = _.create({ 'a': _.create({ 'b': _.create({ 'c': 3 }) }) });
         *
         * _.hasIn(object, 'a');
         * // => true
         *
         * _.hasIn(object, 'a.b.c');
         * // => true
         *
         * _.hasIn(object, ['a', 'b', 'c']);
         * // => true
         *
         * _.hasIn(object, 'b');
         * // => false
         */
        function hasIn(object, path) {
            return hasPath(object, path, baseHasIn);
        }

        /**
         * Creates an object composed of the inverted keys and values of `object`.
         * If `object` contains duplicate values, subsequent values overwrite property
         * assignments of previous values.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to invert.
         * @returns {Object} Returns the new inverted object.
         * @example
         *
         * var object = { 'a': 1, 'b': 2, 'c': 1 };
         *
         * _.invert(object);
         * // => { '1': 'c', '2': 'b' }
         */
        var invert = createInverter(function(result, value, key) {
            result[value] = key;
        }, constant(identity));

        /**
         * This method is like `_.invert` except that the inverted object is generated
         * from the results of running each element of `object` through `iteratee`.
         * The corresponding inverted value of each inverted key is an array of keys
         * responsible for generating the inverted value. The iteratee is invoked
         * with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to invert.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {Object} Returns the new inverted object.
         * @example
         *
         * var object = { 'a': 1, 'b': 2, 'c': 1 };
         *
         * _.invertBy(object);
         * // => { '1': ['a', 'c'], '2': ['b'] }
         *
         * _.invertBy(object, function(value) {
     *   return 'group' + value;
     * });
         * // => { 'group1': ['a', 'c'], 'group2': ['b'] }
         */
        var invertBy = createInverter(function(result, value, key) {
            if (hasOwnProperty.call(result, value)) {
                result[value].push(key);
            } else {
                result[value] = [key];
            }
        }, getIteratee);

        /**
         * Invokes the method at `path` of `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @param {Array|string} path The path of the method to invoke.
         * @param {...*} [args] The arguments to invoke the method with.
         * @returns {*} Returns the result of the invoked method.
         * @example
         *
         * var object = { 'a': [{ 'b': { 'c': [1, 2, 3, 4] } }] };
         *
         * _.invoke(object, 'a[0].b.c.slice', 1, 3);
         * // => [2, 3]
         */
        var invoke = rest(baseInvoke);

        /**
         * Creates an array of the own enumerable property names of `object`.
         *
         * **Note:** Non-object values are coerced to objects. See the
         * [ES spec](http://ecma-international.org/ecma-262/6.0/#sec-object.keys)
         * for more details.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @returns {Array} Returns the array of property names.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.keys(new Foo);
         * // => ['a', 'b'] (iteration order is not guaranteed)
         *
         * _.keys('hi');
         * // => ['0', '1']
         */
        function keys(object) {
            var isProto = isPrototype(object);
            if (!(isProto || isArrayLike(object))) {
                return baseKeys(object);
            }
            var indexes = indexKeys(object),
                skipIndexes = !!indexes,
                result = indexes || [],
                length = result.length;

            for (var key in object) {
                if (baseHas(object, key) &&
                    !(skipIndexes && (key == 'length' || isIndex(key, length))) &&
                    !(isProto && key == 'constructor')) {
                    result.push(key);
                }
            }
            return result;
        }

        /**
         * Creates an array of the own and inherited enumerable property names of `object`.
         *
         * **Note:** Non-object values are coerced to objects.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @returns {Array} Returns the array of property names.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.keysIn(new Foo);
         * // => ['a', 'b', 'c'] (iteration order is not guaranteed)
         */
        function keysIn(object) {
            var index = -1,
                isProto = isPrototype(object),
                props = baseKeysIn(object),
                propsLength = props.length,
                indexes = indexKeys(object),
                skipIndexes = !!indexes,
                result = indexes || [],
                length = result.length;

            while (++index < propsLength) {
                var key = props[index];
                if (!(skipIndexes && (key == 'length' || isIndex(key, length))) &&
                    !(key == 'constructor' && (isProto || !hasOwnProperty.call(object, key)))) {
                    result.push(key);
                }
            }
            return result;
        }

        /**
         * The opposite of `_.mapValues`; this method creates an object with the
         * same values as `object` and keys generated by running each own enumerable
         * property of `object` through `iteratee`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Object} Returns the new mapped object.
         * @example
         *
         * _.mapKeys({ 'a': 1, 'b': 2 }, function(value, key) {
     *   return key + value;
     * });
         * // => { 'a1': 1, 'b2': 2 }
         */
        function mapKeys(object, iteratee) {
            var result = {};
            iteratee = getIteratee(iteratee, 3);

            baseForOwn(object, function(value, key, object) {
                result[iteratee(value, key, object)] = value;
            });
            return result;
        }

        /**
         * Creates an object with the same keys as `object` and values generated by
         * running each own enumerable property of `object` through `iteratee`. The
         * iteratee function is invoked with three arguments: (value, key, object).
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Object} Returns the new mapped object.
         * @example
         *
         * var users = {
     *   'fred':    { 'user': 'fred',    'age': 40 },
     *   'pebbles': { 'user': 'pebbles', 'age': 1 }
     * };
         *
         * _.mapValues(users, function(o) { return o.age; });
         * // => { 'fred': 40, 'pebbles': 1 } (iteration order is not guaranteed)
         *
         * // The `_.property` iteratee shorthand.
         * _.mapValues(users, 'age');
         * // => { 'fred': 40, 'pebbles': 1 } (iteration order is not guaranteed)
         */
        function mapValues(object, iteratee) {
            var result = {};
            iteratee = getIteratee(iteratee, 3);

            baseForOwn(object, function(value, key, object) {
                result[key] = iteratee(value, key, object);
            });
            return result;
        }

        /**
         * Recursively merges own and inherited enumerable properties of source
         * objects into the destination object, skipping source properties that resolve
         * to `undefined`. Array and plain object properties are merged recursively.
         * Other objects and value types are overridden by assignment. Source objects
         * are applied from left to right. Subsequent sources overwrite property
         * assignments of previous sources.
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The destination object.
         * @param {...Object} [sources] The source objects.
         * @returns {Object} Returns `object`.
         * @example
         *
         * var users = {
     *   'data': [{ 'user': 'barney' }, { 'user': 'fred' }]
     * };
         *
         * var ages = {
     *   'data': [{ 'age': 36 }, { 'age': 40 }]
     * };
         *
         * _.merge(users, ages);
         * // => { 'data': [{ 'user': 'barney', 'age': 36 }, { 'user': 'fred', 'age': 40 }] }
         */
        var merge = createAssigner(function(object, source, srcIndex) {
            baseMerge(object, source, srcIndex);
        });

        /**
         * This method is like `_.merge` except that it accepts `customizer` which
         * is invoked to produce the merged values of the destination and source
         * properties. If `customizer` returns `undefined` merging is handled by the
         * method instead. The `customizer` is invoked with seven arguments:
         * (objValue, srcValue, key, object, source, stack).
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The destination object.
         * @param {...Object} sources The source objects.
         * @param {Function} customizer The function to customize assigned values.
         * @returns {Object} Returns `object`.
         * @example
         *
         * function customizer(objValue, srcValue) {
     *   if (_.isArray(objValue)) {
     *     return objValue.concat(srcValue);
     *   }
     * }
         *
         * var object = {
     *   'fruits': ['apple'],
     *   'vegetables': ['beet']
     * };
         *
         * var other = {
     *   'fruits': ['banana'],
     *   'vegetables': ['carrot']
     * };
         *
         * _.mergeWith(object, other, customizer);
         * // => { 'fruits': ['apple', 'banana'], 'vegetables': ['beet', 'carrot'] }
         */
        var mergeWith = createAssigner(function(object, source, srcIndex, customizer) {
            baseMerge(object, source, srcIndex, customizer);
        });

        /**
         * The opposite of `_.pick`; this method creates an object composed of the
         * own and inherited enumerable properties of `object` that are not omitted.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The source object.
         * @param {...(string|string[])} [props] The property names to omit, specified
         *  individually or in arrays..
         * @returns {Object} Returns the new object.
         * @example
         *
         * var object = { 'a': 1, 'b': '2', 'c': 3 };
         *
         * _.omit(object, ['a', 'c']);
         * // => { 'b': '2' }
         */
        var omit = rest(function(object, props) {
            if (object == null) {
                return {};
            }
            props = arrayMap(baseFlatten(props), String);
            return basePick(object, baseDifference(keysIn(object), props));
        });

        /**
         * The opposite of `_.pickBy`; this method creates an object composed of the
         * own and inherited enumerable properties of `object` that `predicate`
         * doesn't return truthy for.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The source object.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per property.
         * @returns {Object} Returns the new object.
         * @example
         *
         * var object = { 'a': 1, 'b': '2', 'c': 3 };
         *
         * _.omitBy(object, _.isNumber);
         * // => { 'b': '2' }
         */
        function omitBy(object, predicate) {
            predicate = getIteratee(predicate, 2);
            return basePickBy(object, function(value, key) {
                return !predicate(value, key);
            });
        }

        /**
         * Creates an object composed of the picked `object` properties.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The source object.
         * @param {...(string|string[])} [props] The property names to pick, specified
         *  individually or in arrays.
         * @returns {Object} Returns the new object.
         * @example
         *
         * var object = { 'a': 1, 'b': '2', 'c': 3 };
         *
         * _.pick(object, ['a', 'c']);
         * // => { 'a': 1, 'c': 3 }
         */
        var pick = rest(function(object, props) {
            return object == null ? {} : basePick(object, baseFlatten(props));
        });

        /**
         * Creates an object composed of the `object` properties `predicate` returns
         * truthy for. The predicate is invoked with two arguments: (value, key).
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The source object.
         * @param {Function|Object|string} [predicate=_.identity] The function invoked per property.
         * @returns {Object} Returns the new object.
         * @example
         *
         * var object = { 'a': 1, 'b': '2', 'c': 3 };
         *
         * _.pickBy(object, _.isNumber);
         * // => { 'a': 1, 'c': 3 }
         */
        function pickBy(object, predicate) {
            return object == null ? {} : basePickBy(object, getIteratee(predicate, 2));
        }

        /**
         * This method is like `_.get` except that if the resolved value is a function
         * it's invoked with the `this` binding of its parent object and its result
         * is returned.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @param {Array|string} path The path of the property to resolve.
         * @param {*} [defaultValue] The value returned if the resolved value is `undefined`.
         * @returns {*} Returns the resolved value.
         * @example
         *
         * var object = { 'a': [{ 'b': { 'c1': 3, 'c2': _.constant(4) } }] };
         *
         * _.result(object, 'a[0].b.c1');
         * // => 3
         *
         * _.result(object, 'a[0].b.c2');
         * // => 4
         *
         * _.result(object, 'a[0].b.c3', 'default');
         * // => 'default'
         *
         * _.result(object, 'a[0].b.c3', _.constant('default'));
         * // => 'default'
         */
        function result(object, path, defaultValue) {
            if (!isKey(path, object)) {
                path = baseToPath(path);
                var result = get(object, path);
                object = parent(object, path);
            } else {
                result = object == null ? undefined : object[path];
            }
            if (result === undefined) {
                result = defaultValue;
            }
            return isFunction(result) ? result.call(object) : result;
        }

        /**
         * Sets the value at `path` of `object`. If a portion of `path` doesn't exist
         * it's created. Arrays are created for missing index properties while objects
         * are created for all other missing properties. Use `_.setWith` to customize
         * `path` creation.
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to modify.
         * @param {Array|string} path The path of the property to set.
         * @param {*} value The value to set.
         * @returns {Object} Returns `object`.
         * @example
         *
         * var object = { 'a': [{ 'b': { 'c': 3 } }] };
         *
         * _.set(object, 'a[0].b.c', 4);
         * console.log(object.a[0].b.c);
         * // => 4
         *
         * _.set(object, 'x[0].y.z', 5);
         * console.log(object.x[0].y.z);
         * // => 5
         */
        function set(object, path, value) {
            return object == null ? object : baseSet(object, path, value);
        }

        /**
         * This method is like `_.set` except that it accepts `customizer` which is
         * invoked to produce the objects of `path`.  If `customizer` returns `undefined`
         * path creation is handled by the method instead. The `customizer` is invoked
         * with three arguments: (nsValue, key, nsObject).
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to modify.
         * @param {Array|string} path The path of the property to set.
         * @param {*} value The value to set.
         * @param {Function} [customizer] The function to customize assigned values.
         * @returns {Object} Returns `object`.
         * @example
         *
         * _.setWith({ '0': { 'length': 2 } }, '[0][1][2]', 3, Object);
         * // => { '0': { '1': { '2': 3 }, 'length': 2 } }
         */
        function setWith(object, path, value, customizer) {
            customizer = typeof customizer == 'function' ? customizer : undefined;
            return object == null ? object : baseSet(object, path, value, customizer);
        }

        /**
         * Creates an array of own enumerable key-value pairs for `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @returns {Array} Returns the new array of key-value pairs.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.toPairs(new Foo);
         * // => [['a', 1], ['b', 2]] (iteration order is not guaranteed)
         */
        function toPairs(object) {
            return baseToPairs(object, keys(object));
        }

        /**
         * Creates an array of own and inherited enumerable key-value pairs for `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @returns {Array} Returns the new array of key-value pairs.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.toPairsIn(new Foo);
         * // => [['a', 1], ['b', 2], ['c', 1]] (iteration order is not guaranteed)
         */
        function toPairsIn(object) {
            return baseToPairs(object, keysIn(object));
        }

        /**
         * An alternative to `_.reduce`; this method transforms `object` to a new
         * `accumulator` object which is the result of running each of its own enumerable
         * properties through `iteratee`, with each invocation potentially mutating
         * the `accumulator` object. The iteratee is invoked with four arguments:
         * (accumulator, value, key, object). Iteratee functions may exit iteration
         * early by explicitly returning `false`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Array|Object} object The object to iterate over.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @param {*} [accumulator] The custom accumulator value.
         * @returns {*} Returns the accumulated value.
         * @example
         *
         * _.transform([2, 3, 4], function(result, n) {
     *   result.push(n *= n);
     *   return n % 2 == 0;
     * }, []);
         * // => [4, 9]
         *
         * _.transform({ 'a': 1, 'b': 2, 'c': 1 }, function(result, value, key) {
     *   (result[value] || (result[value] = [])).push(key);
     * }, {});
         * // => { '1': ['a', 'c'], '2': ['b'] }
         */
        function transform(object, iteratee, accumulator) {
            var isArr = isArray(object) || isTypedArray(object);
            iteratee = getIteratee(iteratee, 4);

            if (accumulator == null) {
                if (isArr || isObject(object)) {
                    var Ctor = object.constructor;
                    if (isArr) {
                        accumulator = isArray(object) ? new Ctor : [];
                    } else {
                        accumulator = baseCreate(isFunction(Ctor) ? Ctor.prototype : undefined);
                    }
                } else {
                    accumulator = {};
                }
            }
            (isArr ? arrayEach : baseForOwn)(object, function(value, index, object) {
                return iteratee(accumulator, value, index, object);
            });
            return accumulator;
        }

        /**
         * Removes the property at `path` of `object`.
         *
         * **Note:** This method mutates `object`.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to modify.
         * @param {Array|string} path The path of the property to unset.
         * @returns {boolean} Returns `true` if the property is deleted, else `false`.
         * @example
         *
         * var object = { 'a': [{ 'b': { 'c': 7 } }] };
         * _.unset(object, 'a[0].b.c');
         * // => true
         *
         * console.log(object);
         * // => { 'a': [{ 'b': {} }] };
         *
         * _.unset(object, 'a[0].b.c');
         * // => true
         *
         * console.log(object);
         * // => { 'a': [{ 'b': {} }] };
         */
        function unset(object, path) {
            return object == null ? true : baseUnset(object, path);
        }

        /**
         * Creates an array of the own enumerable property values of `object`.
         *
         * **Note:** Non-object values are coerced to objects.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @returns {Array} Returns the array of property values.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.values(new Foo);
         * // => [1, 2] (iteration order is not guaranteed)
         *
         * _.values('hi');
         * // => ['h', 'i']
         */
        function values(object) {
            return object ? baseValues(object, keys(object)) : [];
        }

        /**
         * Creates an array of the own and inherited enumerable property values of `object`.
         *
         * **Note:** Non-object values are coerced to objects.
         *
         * @static
         * @memberOf _
         * @category Object
         * @param {Object} object The object to query.
         * @returns {Array} Returns the array of property values.
         * @example
         *
         * function Foo() {
     *   this.a = 1;
     *   this.b = 2;
     * }
         *
         * Foo.prototype.c = 3;
         *
         * _.valuesIn(new Foo);
         * // => [1, 2, 3] (iteration order is not guaranteed)
         */
        function valuesIn(object) {
            return object == null ? baseValues(object, keysIn(object)) : [];
        }

        /*------------------------------------------------------------------------*/

        /**
         * Clamps `number` within the inclusive `lower` and `upper` bounds.
         *
         * @static
         * @memberOf _
         * @category Number
         * @param {number} number The number to clamp.
         * @param {number} [lower] The lower bound.
         * @param {number} upper The upper bound.
         * @returns {number} Returns the clamped number.
         * @example
         *
         * _.clamp(-10, -5, 5);
         * // => -5
         *
         * _.clamp(10, -5, 5);
         * // => 5
         */
        function clamp(number, lower, upper) {
            if (upper === undefined) {
                upper = lower;
                lower = undefined;
            }
            if (upper !== undefined) {
                upper = toNumber(upper);
                upper = upper === upper ? upper : 0;
            }
            if (lower !== undefined) {
                lower = toNumber(lower);
                lower = lower === lower ? lower : 0;
            }
            return baseClamp(toNumber(number), lower, upper);
        }

        /**
         * Checks if `n` is between `start` and up to but not including, `end`. If
         * `end` is not specified it's set to `start` with `start` then set to `0`.
         * If `start` is greater than `end` the params are swapped to support
         * negative ranges.
         *
         * @static
         * @memberOf _
         * @category Number
         * @param {number} number The number to check.
         * @param {number} [start=0] The start of the range.
         * @param {number} end The end of the range.
         * @returns {boolean} Returns `true` if `number` is in the range, else `false`.
         * @example
         *
         * _.inRange(3, 2, 4);
         * // => true
         *
         * _.inRange(4, 8);
         * // => true
         *
         * _.inRange(4, 2);
         * // => false
         *
         * _.inRange(2, 2);
         * // => false
         *
         * _.inRange(1.2, 2);
         * // => true
         *
         * _.inRange(5.2, 4);
         * // => false
         *
         * _.inRange(-3, -2, -6);
         * // => true
         */
        function inRange(number, start, end) {
            start = toNumber(start) || 0;
            if (end === undefined) {
                end = start;
                start = 0;
            } else {
                end = toNumber(end) || 0;
            }
            number = toNumber(number);
            return baseInRange(number, start, end);
        }

        /**
         * Produces a random number between the inclusive `lower` and `upper` bounds.
         * If only one argument is provided a number between `0` and the given number
         * is returned. If `floating` is `true`, or either `lower` or `upper` are floats,
         * a floating-point number is returned instead of an integer.
         *
         * **Note:** JavaScript follows the IEEE-754 standard for resolving
         * floating-point values which can produce unexpected results.
         *
         * @static
         * @memberOf _
         * @category Number
         * @param {number} [lower=0] The lower bound.
         * @param {number} [upper=1] The upper bound.
         * @param {boolean} [floating] Specify returning a floating-point number.
         * @returns {number} Returns the random number.
         * @example
         *
         * _.random(0, 5);
         * // => an integer between 0 and 5
         *
         * _.random(5);
         * // => also an integer between 0 and 5
         *
         * _.random(5, true);
         * // => a floating-point number between 0 and 5
         *
         * _.random(1.2, 5.2);
         * // => a floating-point number between 1.2 and 5.2
         */
        function random(lower, upper, floating) {
            if (floating && typeof floating != 'boolean' && isIterateeCall(lower, upper, floating)) {
                upper = floating = undefined;
            }
            if (floating === undefined) {
                if (typeof upper == 'boolean') {
                    floating = upper;
                    upper = undefined;
                }
                else if (typeof lower == 'boolean') {
                    floating = lower;
                    lower = undefined;
                }
            }
            if (lower === undefined && upper === undefined) {
                lower = 0;
                upper = 1;
            }
            else {
                lower = toNumber(lower) || 0;
                if (upper === undefined) {
                    upper = lower;
                    lower = 0;
                } else {
                    upper = toNumber(upper) || 0;
                }
            }
            if (lower > upper) {
                var temp = lower;
                lower = upper;
                upper = temp;
            }
            if (floating || lower % 1 || upper % 1) {
                var rand = nativeRandom();
                return nativeMin(lower + (rand * (upper - lower + freeParseFloat('1e-' + ((rand + '').length - 1)))), upper);
            }
            return baseRandom(lower, upper);
        }

        /*------------------------------------------------------------------------*/

        /**
         * Converts `string` to [camel case](https://en.wikipedia.org/wiki/CamelCase).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the camel cased string.
         * @example
         *
         * _.camelCase('Foo Bar');
         * // => 'fooBar'
         *
         * _.camelCase('--foo-bar');
         * // => 'fooBar'
         *
         * _.camelCase('__foo_bar__');
         * // => 'fooBar'
         */
        var camelCase = createCompounder(function(result, word, index) {
            word = word.toLowerCase();
            return result + (index ? capitalize(word) : word);
        });

        /**
         * Converts the first character of `string` to upper case and the remaining
         * to lower case.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to capitalize.
         * @returns {string} Returns the capitalized string.
         * @example
         *
         * _.capitalize('FRED');
         * // => 'Fred'
         */
        function capitalize(string) {
            return upperFirst(toString(string).toLowerCase());
        }

        /**
         * Deburrs `string` by converting [latin-1 supplementary letters](https://en.wikipedia.org/wiki/Latin-1_Supplement_(Unicode_block)#Character_table)
         * to basic latin letters and removing [combining diacritical marks](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to deburr.
         * @returns {string} Returns the deburred string.
         * @example
         *
         * _.deburr('dГ©jГ  vu');
         * // => 'deja vu'
         */
        function deburr(string) {
            string = toString(string);
            return string && string.replace(reLatin1, deburrLetter).replace(reComboMark, '');
        }

        /**
         * Checks if `string` ends with the given target string.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to search.
         * @param {string} [target] The string to search for.
         * @param {number} [position=string.length] The position to search from.
         * @returns {boolean} Returns `true` if `string` ends with `target`, else `false`.
         * @example
         *
         * _.endsWith('abc', 'c');
         * // => true
         *
         * _.endsWith('abc', 'b');
         * // => false
         *
         * _.endsWith('abc', 'b', 2);
         * // => true
         */
        function endsWith(string, target, position) {
            string = toString(string);
            target = typeof target == 'string' ? target : (target + '');

            var length = string.length;
            position = position === undefined
                ? length
                : baseClamp(toInteger(position), 0, length);

            position -= target.length;
            return position >= 0 && string.indexOf(target, position) == position;
        }

        /**
         * Converts the characters "&", "<", ">", '"', "'", and "\`" in `string` to
         * their corresponding HTML entities.
         *
         * **Note:** No other characters are escaped. To escape additional
         * characters use a third-party library like [_he_](https://mths.be/he).
         *
         * Though the ">" character is escaped for symmetry, characters like
         * ">" and "/" don't need escaping in HTML and have no special meaning
         * unless they're part of a tag or unquoted attribute value.
         * See [Mathias Bynens's article](https://mathiasbynens.be/notes/ambiguous-ampersands)
         * (under "semi-related fun fact") for more details.
         *
         * Backticks are escaped because in IE < 9, they can break out of
         * attribute values or HTML comments. See [#59](https://html5sec.org/#59),
         * [#102](https://html5sec.org/#102), [#108](https://html5sec.org/#108), and
         * [#133](https://html5sec.org/#133) of the [HTML5 Security Cheatsheet](https://html5sec.org/)
         * for more details.
         *
         * When working with HTML you should always [quote attribute values](http://wonko.com/post/html-escaping)
         * to reduce XSS vectors.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to escape.
         * @returns {string} Returns the escaped string.
         * @example
         *
         * _.escape('fred, barney, & pebbles');
         * // => 'fred, barney, &amp; pebbles'
         */
        function escape(string) {
            string = toString(string);
            return (string && reHasUnescapedHtml.test(string))
                ? string.replace(reUnescapedHtml, escapeHtmlChar)
                : string;
        }

        /**
         * Escapes the `RegExp` special characters "^", "$", "\", ".", "*", "+",
         * "?", "(", ")", "[", "]", "{", "}", and "|" in `string`.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to escape.
         * @returns {string} Returns the escaped string.
         * @example
         *
         * _.escapeRegExp('[lodash](https://lodash.com/)');
         * // => '\[lodash\]\(https://lodash\.com/\)'
         */
        function escapeRegExp(string) {
            string = toString(string);
            return (string && reHasRegExpChar.test(string))
                ? string.replace(reRegExpChar, '\\$&')
                : string;
        }

        /**
         * Converts `string` to [kebab case](https://en.wikipedia.org/wiki/Letter_case#Special_case_styles).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the kebab cased string.
         * @example
         *
         * _.kebabCase('Foo Bar');
         * // => 'foo-bar'
         *
         * _.kebabCase('fooBar');
         * // => 'foo-bar'
         *
         * _.kebabCase('__foo_bar__');
         * // => 'foo-bar'
         */
        var kebabCase = createCompounder(function(result, word, index) {
            return result + (index ? '-' : '') + word.toLowerCase();
        });

        /**
         * Converts `string`, as space separated words, to lower case.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the lower cased string.
         * @example
         *
         * _.lowerCase('--Foo-Bar');
         * // => 'foo bar'
         *
         * _.lowerCase('fooBar');
         * // => 'foo bar'
         *
         * _.lowerCase('__FOO_BAR__');
         * // => 'foo bar'
         */
        var lowerCase = createCompounder(function(result, word, index) {
            return result + (index ? ' ' : '') + word.toLowerCase();
        });

        /**
         * Converts the first character of `string` to lower case.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the converted string.
         * @example
         *
         * _.lowerFirst('Fred');
         * // => 'fred'
         *
         * _.lowerFirst('FRED');
         * // => 'fRED'
         */
        var lowerFirst = createCaseFirst('toLowerCase');

        /**
         * Converts the first character of `string` to upper case.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the converted string.
         * @example
         *
         * _.upperFirst('fred');
         * // => 'Fred'
         *
         * _.upperFirst('FRED');
         * // => 'FRED'
         */
        var upperFirst = createCaseFirst('toUpperCase');

        /**
         * Pads `string` on the left and right sides if it's shorter than `length`.
         * Padding characters are truncated if they can't be evenly divided by `length`.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to pad.
         * @param {number} [length=0] The padding length.
         * @param {string} [chars=' '] The string used as padding.
         * @returns {string} Returns the padded string.
         * @example
         *
         * _.pad('abc', 8);
         * // => '  abc   '
         *
         * _.pad('abc', 8, '_-');
         * // => '_-abc_-_'
         *
         * _.pad('abc', 3);
         * // => 'abc'
         */
        function pad(string, length, chars) {
            string = toString(string);
            length = toInteger(length);

            var strLength = stringSize(string);
            if (!length || strLength >= length) {
                return string;
            }
            var mid = (length - strLength) / 2,
                leftLength = nativeFloor(mid),
                rightLength = nativeCeil(mid);

            return createPadding('', leftLength, chars) + string + createPadding('', rightLength, chars);
        }

        /**
         * Pads `string` on the right side if it's shorter than `length`. Padding
         * characters are truncated if they exceed `length`.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to pad.
         * @param {number} [length=0] The padding length.
         * @param {string} [chars=' '] The string used as padding.
         * @returns {string} Returns the padded string.
         * @example
         *
         * _.padEnd('abc', 6);
         * // => 'abc   '
         *
         * _.padEnd('abc', 6, '_-');
         * // => 'abc_-_'
         *
         * _.padEnd('abc', 3);
         * // => 'abc'
         */
        function padEnd(string, length, chars) {
            string = toString(string);
            return string + createPadding(string, length, chars);
        }

        /**
         * Pads `string` on the left side if it's shorter than `length`. Padding
         * characters are truncated if they exceed `length`.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to pad.
         * @param {number} [length=0] The padding length.
         * @param {string} [chars=' '] The string used as padding.
         * @returns {string} Returns the padded string.
         * @example
         *
         * _.padStart('abc', 6);
         * // => '   abc'
         *
         * _.padStart('abc', 6, '_-');
         * // => '_-_abc'
         *
         * _.padStart('abc', 3);
         * // => 'abc'
         */
        function padStart(string, length, chars) {
            string = toString(string);
            return createPadding(string, length, chars) + string;
        }

        /**
         * Converts `string` to an integer of the specified radix. If `radix` is
         * `undefined` or `0`, a `radix` of `10` is used unless `value` is a hexadecimal,
         * in which case a `radix` of `16` is used.
         *
         * **Note:** This method aligns with the [ES5 implementation](https://es5.github.io/#x15.1.2.2)
         * of `parseInt`.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} string The string to convert.
         * @param {number} [radix] The radix to interpret `value` by.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {number} Returns the converted integer.
         * @example
         *
         * _.parseInt('08');
         * // => 8
         *
         * _.map(['6', '08', '10'], _.parseInt);
         * // => [6, 8, 10]
         */
        function parseInt(string, radix, guard) {
            // Chrome fails to trim leading <BOM> whitespace characters.
            // See https://code.google.com/p/v8/issues/detail?id=3109 for more details.
            if (guard || radix == null) {
                radix = 0;
            } else if (radix) {
                radix = +radix;
            }
            string = toString(string).replace(reTrim, '');
            return nativeParseInt(string, radix || (reHasHexPrefix.test(string) ? 16 : 10));
        }

        /**
         * Repeats the given string `n` times.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to repeat.
         * @param {number} [n=0] The number of times to repeat the string.
         * @returns {string} Returns the repeated string.
         * @example
         *
         * _.repeat('*', 3);
         * // => '***'
         *
         * _.repeat('abc', 2);
         * // => 'abcabc'
         *
         * _.repeat('abc', 0);
         * // => ''
         */
        function repeat(string, n) {
            string = toString(string);
            n = toInteger(n);

            var result = '';
            if (!string || n < 1 || n > MAX_SAFE_INTEGER) {
                return result;
            }
            // Leverage the exponentiation by squaring algorithm for a faster repeat.
            // See https://en.wikipedia.org/wiki/Exponentiation_by_squaring for more details.
            do {
                if (n % 2) {
                    result += string;
                }
                n = nativeFloor(n / 2);
                string += string;
            } while (n);

            return result;
        }

        /**
         * Replaces matches for `pattern` in `string` with `replacement`.
         *
         * **Note:** This method is based on [`String#replace`](https://mdn.io/String/replace).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to modify.
         * @param {RegExp|string} pattern The pattern to replace.
         * @param {Function|string} replacement The match replacement.
         * @returns {string} Returns the modified string.
         * @example
         *
         * _.replace('Hi Fred', 'Fred', 'Barney');
         * // => 'Hi Barney'
         */
        function replace() {
            var args = arguments,
                string = toString(args[0]);

            return args.length < 3 ? string : string.replace(args[1], args[2]);
        }

        /**
         * Converts `string` to [snake case](https://en.wikipedia.org/wiki/Snake_case).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the snake cased string.
         * @example
         *
         * _.snakeCase('Foo Bar');
         * // => 'foo_bar'
         *
         * _.snakeCase('fooBar');
         * // => 'foo_bar'
         *
         * _.snakeCase('--foo-bar');
         * // => 'foo_bar'
         */
        var snakeCase = createCompounder(function(result, word, index) {
            return result + (index ? '_' : '') + word.toLowerCase();
        });

        /**
         * Splits `string` by `separator`.
         *
         * **Note:** This method is based on [`String#split`](https://mdn.io/String/split).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to split.
         * @param {RegExp|string} separator The separator pattern to split by.
         * @param {number} [limit] The length to truncate results to.
         * @returns {Array} Returns the new array of string segments.
         * @example
         *
         * _.split('a-b-c', '-', 2);
         * // => ['a', 'b']
         */
        function split(string, separator, limit) {
            return toString(string).split(separator, limit);
        }

        /**
         * Converts `string` to [start case](https://en.wikipedia.org/wiki/Letter_case#Stylistic_or_specialised_usage).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the start cased string.
         * @example
         *
         * _.startCase('--foo-bar');
         * // => 'Foo Bar'
         *
         * _.startCase('fooBar');
         * // => 'Foo Bar'
         *
         * _.startCase('__foo_bar__');
         * // => 'Foo Bar'
         */
        var startCase = createCompounder(function(result, word, index) {
            return result + (index ? ' ' : '') + capitalize(word);
        });

        /**
         * Checks if `string` starts with the given target string.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to search.
         * @param {string} [target] The string to search for.
         * @param {number} [position=0] The position to search from.
         * @returns {boolean} Returns `true` if `string` starts with `target`, else `false`.
         * @example
         *
         * _.startsWith('abc', 'a');
         * // => true
         *
         * _.startsWith('abc', 'b');
         * // => false
         *
         * _.startsWith('abc', 'b', 1);
         * // => true
         */
        function startsWith(string, target, position) {
            string = toString(string);
            position = baseClamp(toInteger(position), 0, string.length);
            return string.lastIndexOf(target, position) == position;
        }

        /**
         * Creates a compiled template function that can interpolate data properties
         * in "interpolate" delimiters, HTML-escape interpolated data properties in
         * "escape" delimiters, and execute JavaScript in "evaluate" delimiters. Data
         * properties may be accessed as free variables in the template. If a setting
         * object is given it takes precedence over `_.templateSettings` values.
         *
         * **Note:** In the development build `_.template` utilizes
         * [sourceURLs](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/#toc-sourceurl)
         * for easier debugging.
         *
         * For more information on precompiling templates see
         * [lodash's custom builds documentation](https://lodash.com/custom-builds).
         *
         * For more information on Chrome extension sandboxes see
         * [Chrome's extensions documentation](https://developer.chrome.com/extensions/sandboxingEval).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The template string.
         * @param {Object} [options] The options object.
         * @param {RegExp} [options.escape] The HTML "escape" delimiter.
         * @param {RegExp} [options.evaluate] The "evaluate" delimiter.
         * @param {Object} [options.imports] An object to import into the template as free variables.
         * @param {RegExp} [options.interpolate] The "interpolate" delimiter.
         * @param {string} [options.sourceURL] The sourceURL of the template's compiled source.
         * @param {string} [options.variable] The data object variable name.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Function} Returns the compiled template function.
         * @example
         *
         * // Use the "interpolate" delimiter to create a compiled template.
         * var compiled = _.template('hello <%= user %>!');
         * compiled({ 'user': 'fred' });
         * // => 'hello fred!'
         *
         * // Use the HTML "escape" delimiter to escape data property values.
         * var compiled = _.template('<b><%- value %></b>');
         * compiled({ 'value': '<script>' });
         * // => '<b>&lt;script&gt;</b>'
         *
         * // Use the "evaluate" delimiter to execute JavaScript and generate HTML.
         * var compiled = _.template('<% _.forEach(users, function(user) { %><li><%- user %></li><% }); %>');
         * compiled({ 'users': ['fred', 'barney'] });
         * // => '<li>fred</li><li>barney</li>'
         *
         * // Use the internal `print` function in "evaluate" delimiters.
         * var compiled = _.template('<% print("hello " + user); %>!');
         * compiled({ 'user': 'barney' });
         * // => 'hello barney!'
         *
         * // Use the ES delimiter as an alternative to the default "interpolate" delimiter.
         * var compiled = _.template('hello ${ user }!');
         * compiled({ 'user': 'pebbles' });
         * // => 'hello pebbles!'
         *
         * // Use custom template delimiters.
         * _.templateSettings.interpolate = /{{([\s\S]+?)}}/g;
         * var compiled = _.template('hello {{ user }}!');
         * compiled({ 'user': 'mustache' });
         * // => 'hello mustache!'
         *
         * // Use backslashes to treat delimiters as plain text.
         * var compiled = _.template('<%= "\\<%- value %\\>" %>');
         * compiled({ 'value': 'ignored' });
         * // => '<%- value %>'
         *
         * // Use the `imports` option to import `jQuery` as `jq`.
         * var text = '<% jq.each(users, function(user) { %><li><%- user %></li><% }); %>';
         * var compiled = _.template(text, { 'imports': { 'jq': jQuery } });
         * compiled({ 'users': ['fred', 'barney'] });
         * // => '<li>fred</li><li>barney</li>'
         *
         * // Use the `sourceURL` option to specify a custom sourceURL for the template.
         * var compiled = _.template('hello <%= user %>!', { 'sourceURL': '/basic/greeting.jst' });
         * compiled(data);
         * // => find the source of "greeting.jst" under the Sources tab or Resources panel of the web inspector
         *
         * // Use the `variable` option to ensure a with-statement isn't used in the compiled template.
         * var compiled = _.template('hi <%= data.user %>!', { 'variable': 'data' });
         * compiled.source;
         * // => function(data) {
     * //   var __t, __p = '';
     * //   __p += 'hi ' + ((__t = ( data.user )) == null ? '' : __t) + '!';
     * //   return __p;
     * // }
         *
         * // Use the `source` property to inline compiled templates for meaningful
         * // line numbers in error messages and stack traces.
         * fs.writeFileSync(path.join(cwd, 'jst.js'), '\
         *   var JST = {\
     *     "main": ' + _.template(mainText).source + '\
     *   };\
         * ');
         */
        function template(string, options, guard) {
            // Based on John Resig's `tmpl` implementation (http://ejohn.org/blog/javascript-micro-templating/)
            // and Laura Doktorova's doT.js (https://github.com/olado/doT).
            var settings = lodash.templateSettings;

            if (guard && isIterateeCall(string, options, guard)) {
                options = undefined;
            }
            string = toString(string);
            options = assignInWith({}, options, settings, assignInDefaults);

            var imports = assignInWith({}, options.imports, settings.imports, assignInDefaults),
                importsKeys = keys(imports),
                importsValues = baseValues(imports, importsKeys);

            var isEscaping,
                isEvaluating,
                index = 0,
                interpolate = options.interpolate || reNoMatch,
                source = "__p += '";

            // Compile the regexp to match each delimiter.
            var reDelimiters = RegExp(
                (options.escape || reNoMatch).source + '|' +
                interpolate.source + '|' +
                (interpolate === reInterpolate ? reEsTemplate : reNoMatch).source + '|' +
                (options.evaluate || reNoMatch).source + '|$'
                , 'g');

            // Use a sourceURL for easier debugging.
            var sourceURL = '//# sourceURL=' +
                ('sourceURL' in options
                        ? options.sourceURL
                        : ('lodash.templateSources[' + (++templateCounter) + ']')
                ) + '\n';

            string.replace(reDelimiters, function(match, escapeValue, interpolateValue, esTemplateValue, evaluateValue, offset) {
                interpolateValue || (interpolateValue = esTemplateValue);

                // Escape characters that can't be included in string literals.
                source += string.slice(index, offset).replace(reUnescapedString, escapeStringChar);

                // Replace delimiters with snippets.
                if (escapeValue) {
                    isEscaping = true;
                    source += "' +\n__e(" + escapeValue + ") +\n'";
                }
                if (evaluateValue) {
                    isEvaluating = true;
                    source += "';\n" + evaluateValue + ";\n__p += '";
                }
                if (interpolateValue) {
                    source += "' +\n((__t = (" + interpolateValue + ")) == null ? '' : __t) +\n'";
                }
                index = offset + match.length;

                // The JS engine embedded in Adobe products needs `match` returned in
                // order to produce the correct `offset` value.
                return match;
            });

            source += "';\n";

            // If `variable` is not specified wrap a with-statement around the generated
            // code to add the data object to the top of the scope chain.
            var variable = options.variable;
            if (!variable) {
                source = 'with (obj) {\n' + source + '\n}\n';
            }
            // Cleanup code by stripping empty strings.
            source = (isEvaluating ? source.replace(reEmptyStringLeading, '') : source)
                .replace(reEmptyStringMiddle, '$1')
                .replace(reEmptyStringTrailing, '$1;');

            // Frame code as the function body.
            source = 'function(' + (variable || 'obj') + ') {\n' +
                (variable
                        ? ''
                        : 'obj || (obj = {});\n'
                ) +
                "var __t, __p = ''" +
                (isEscaping
                        ? ', __e = _.escape'
                        : ''
                ) +
                (isEvaluating
                        ? ', __j = Array.prototype.join;\n' +
                    "function print() { __p += __j.call(arguments, '') }\n"
                        : ';\n'
                ) +
                source +
                'return __p\n}';

            var result = attempt(function() {
                return Function(importsKeys, sourceURL + 'return ' + source).apply(undefined, importsValues);
            });

            // Provide the compiled function's source by its `toString` method or
            // the `source` property as a convenience for inlining compiled templates.
            result.source = source;
            if (isError(result)) {
                throw result;
            }
            return result;
        }

        /**
         * Converts `string`, as a whole, to lower case.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the lower cased string.
         * @example
         *
         * _.toLower('--Foo-Bar');
         * // => '--foo-bar'
         *
         * _.toLower('fooBar');
         * // => 'foobar'
         *
         * _.toLower('__FOO_BAR__');
         * // => '__foo_bar__'
         */
        function toLower(value) {
            return toString(value).toLowerCase();
        }

        /**
         * Converts `string`, as a whole, to upper case.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the upper cased string.
         * @example
         *
         * _.toUpper('--foo-bar');
         * // => '--FOO-BAR'
         *
         * _.toUpper('fooBar');
         * // => 'FOOBAR'
         *
         * _.toUpper('__foo_bar__');
         * // => '__FOO_BAR__'
         */
        function toUpper(value) {
            return toString(value).toUpperCase();
        }

        /**
         * Removes leading and trailing whitespace or specified characters from `string`.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to trim.
         * @param {string} [chars=whitespace] The characters to trim.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {string} Returns the trimmed string.
         * @example
         *
         * _.trim('  abc  ');
         * // => 'abc'
         *
         * _.trim('-_-abc-_-', '_-');
         * // => 'abc'
         *
         * _.map(['  foo  ', '  bar  '], _.trim);
         * // => ['foo', 'bar']
         */
        function trim(string, chars, guard) {
            string = toString(string);
            if (!string) {
                return string;
            }
            if (guard || chars === undefined) {
                return string.replace(reTrim, '');
            }
            chars = (chars + '');
            if (!chars) {
                return string;
            }
            var strSymbols = stringToArray(string),
                chrSymbols = stringToArray(chars);

            return strSymbols.slice(charsStartIndex(strSymbols, chrSymbols), charsEndIndex(strSymbols, chrSymbols) + 1).join('');
        }

        /**
         * Removes trailing whitespace or specified characters from `string`.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to trim.
         * @param {string} [chars=whitespace] The characters to trim.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {string} Returns the trimmed string.
         * @example
         *
         * _.trimEnd('  abc  ');
         * // => '  abc'
         *
         * _.trimEnd('-_-abc-_-', '_-');
         * // => '-_-abc'
         */
        function trimEnd(string, chars, guard) {
            string = toString(string);
            if (!string) {
                return string;
            }
            if (guard || chars === undefined) {
                return string.replace(reTrimEnd, '');
            }
            chars = (chars + '');
            if (!chars) {
                return string;
            }
            var strSymbols = stringToArray(string);
            return strSymbols.slice(0, charsEndIndex(strSymbols, stringToArray(chars)) + 1).join('');
        }

        /**
         * Removes leading whitespace or specified characters from `string`.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to trim.
         * @param {string} [chars=whitespace] The characters to trim.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {string} Returns the trimmed string.
         * @example
         *
         * _.trimStart('  abc  ');
         * // => 'abc  '
         *
         * _.trimStart('-_-abc-_-', '_-');
         * // => 'abc-_-'
         */
        function trimStart(string, chars, guard) {
            string = toString(string);
            if (!string) {
                return string;
            }
            if (guard || chars === undefined) {
                return string.replace(reTrimStart, '');
            }
            chars = (chars + '');
            if (!chars) {
                return string;
            }
            var strSymbols = stringToArray(string);
            return strSymbols.slice(charsStartIndex(strSymbols, stringToArray(chars))).join('');
        }

        /**
         * Truncates `string` if it's longer than the given maximum string length.
         * The last characters of the truncated string are replaced with the omission
         * string which defaults to "...".
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to truncate.
         * @param {Object} [options] The options object.
         * @param {number} [options.length=30] The maximum string length.
         * @param {string} [options.omission='...'] The string to indicate text is omitted.
         * @param {RegExp|string} [options.separator] The separator pattern to truncate to.
         * @returns {string} Returns the truncated string.
         * @example
         *
         * _.truncate('hi-diddly-ho there, neighborino');
         * // => 'hi-diddly-ho there, neighbo...'
         *
         * _.truncate('hi-diddly-ho there, neighborino', {
     *   'length': 24,
     *   'separator': ' '
     * });
         * // => 'hi-diddly-ho there,...'
         *
         * _.truncate('hi-diddly-ho there, neighborino', {
     *   'length': 24,
     *   'separator': /,? +/
     * });
         * // => 'hi-diddly-ho there...'
         *
         * _.truncate('hi-diddly-ho there, neighborino', {
     *   'omission': ' [...]'
     * });
         * // => 'hi-diddly-ho there, neig [...]'
         */
        function truncate(string, options) {
            var length = DEFAULT_TRUNC_LENGTH,
                omission = DEFAULT_TRUNC_OMISSION;

            if (isObject(options)) {
                var separator = 'separator' in options ? options.separator : separator;
                length = 'length' in options ? toInteger(options.length) : length;
                omission = 'omission' in options ? toString(options.omission) : omission;
            }
            string = toString(string);

            var strLength = string.length;
            if (reHasComplexSymbol.test(string)) {
                var strSymbols = stringToArray(string);
                strLength = strSymbols.length;
            }
            if (length >= strLength) {
                return string;
            }
            var end = length - stringSize(omission);
            if (end < 1) {
                return omission;
            }
            var result = strSymbols
                ? strSymbols.slice(0, end).join('')
                : string.slice(0, end);

            if (separator === undefined) {
                return result + omission;
            }
            if (strSymbols) {
                end += (result.length - end);
            }
            if (isRegExp(separator)) {
                if (string.slice(end).search(separator)) {
                    var match,
                        substring = result;

                    if (!separator.global) {
                        separator = RegExp(separator.source, toString(reFlags.exec(separator)) + 'g');
                    }
                    separator.lastIndex = 0;
                    while ((match = separator.exec(substring))) {
                        var newEnd = match.index;
                    }
                    result = result.slice(0, newEnd === undefined ? end : newEnd);
                }
            } else if (string.indexOf(separator, end) != end) {
                var index = result.lastIndexOf(separator);
                if (index > -1) {
                    result = result.slice(0, index);
                }
            }
            return result + omission;
        }

        /**
         * The inverse of `_.escape`; this method converts the HTML entities
         * `&amp;`, `&lt;`, `&gt;`, `&quot;`, `&#39;`, and `&#96;` in `string` to their
         * corresponding characters.
         *
         * **Note:** No other HTML entities are unescaped. To unescape additional HTML
         * entities use a third-party library like [_he_](https://mths.be/he).
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to unescape.
         * @returns {string} Returns the unescaped string.
         * @example
         *
         * _.unescape('fred, barney, &amp; pebbles');
         * // => 'fred, barney, & pebbles'
         */
        function unescape(string) {
            string = toString(string);
            return (string && reHasEscapedHtml.test(string))
                ? string.replace(reEscapedHtml, unescapeHtmlChar)
                : string;
        }

        /**
         * Converts `string`, as space separated words, to upper case.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to convert.
         * @returns {string} Returns the upper cased string.
         * @example
         *
         * _.upperCase('--foo-bar');
         * // => 'FOO BAR'
         *
         * _.upperCase('fooBar');
         * // => 'FOO BAR'
         *
         * _.upperCase('__foo_bar__');
         * // => 'FOO BAR'
         */
        var upperCase = createCompounder(function(result, word, index) {
            return result + (index ? ' ' : '') + word.toUpperCase();
        });

        /**
         * Splits `string` into an array of its words.
         *
         * @static
         * @memberOf _
         * @category String
         * @param {string} [string=''] The string to inspect.
         * @param {RegExp|string} [pattern] The pattern to match words.
         * @param- {Object} [guard] Enables use as an iteratee for functions like `_.map`.
         * @returns {Array} Returns the words of `string`.
         * @example
         *
         * _.words('fred, barney, & pebbles');
         * // => ['fred', 'barney', 'pebbles']
         *
         * _.words('fred, barney, & pebbles', /[^, ]+/g);
         * // => ['fred', 'barney', '&', 'pebbles']
         */
        function words(string, pattern, guard) {
            string = toString(string);
            pattern = guard ? undefined : pattern;

            if (pattern === undefined) {
                pattern = reHasComplexWord.test(string) ? reComplexWord : reBasicWord;
            }
            return string.match(pattern) || [];
        }

        /*------------------------------------------------------------------------*/

        /**
         * Attempts to invoke `func`, returning either the result or the caught error
         * object. Any additional arguments are provided to `func` when it's invoked.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Function} func The function to attempt.
         * @returns {*} Returns the `func` result or error object.
         * @example
         *
         * // Avoid throwing errors for invalid selectors.
         * var elements = _.attempt(function(selector) {
     *   return document.querySelectorAll(selector);
     * }, '>_>');
         *
         * if (_.isError(elements)) {
     *   elements = [];
     * }
         */
        var attempt = rest(function(func, args) {
            try {
                return apply(func, undefined, args);
            } catch (e) {
                return isObject(e) ? e : new Error(e);
            }
        });

        /**
         * Binds methods of an object to the object itself, overwriting the existing
         * method.
         *
         * **Note:** This method doesn't set the "length" property of bound functions.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Object} object The object to bind and assign the bound methods to.
         * @param {...(string|string[])} methodNames The object method names to bind,
         *  specified individually or in arrays.
         * @returns {Object} Returns `object`.
         * @example
         *
         * var view = {
     *   'label': 'docs',
     *   'onClick': function() {
     *     console.log('clicked ' + this.label);
     *   }
     * };
         *
         * _.bindAll(view, 'onClick');
         * jQuery(element).on('click', view.onClick);
         * // => logs 'clicked docs' when clicked
         */
        var bindAll = rest(function(object, methodNames) {
            arrayEach(baseFlatten(methodNames), function(key) {
                object[key] = bind(object[key], object);
            });
            return object;
        });

        /**
         * Creates a function that iterates over `pairs` invoking the corresponding
         * function of the first predicate to return truthy. The predicate-function
         * pairs are invoked with the `this` binding and arguments of the created
         * function.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Array} pairs The predicate-function pairs.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var func = _.cond([
         *   [_.matches({ 'a': 1 }),           _.constant('matches A')],
         *   [_.conforms({ 'b': _.isNumber }), _.constant('matches B')],
         *   [_.constant(true),                _.constant('no match')]
         * ]);
         *
         * func({ 'a': 1, 'b': 2 });
         * // => 'matches A'
         *
         * func({ 'a': 0, 'b': 1 });
         * // => 'matches B'
         *
         * func({ 'a': '1', 'b': '2' });
         * // => 'no match'
         */
        function cond(pairs) {
            var length = pairs ? pairs.length : 0,
                toIteratee = getIteratee();

            pairs = !length ? [] : arrayMap(pairs, function(pair) {
                if (typeof pair[1] != 'function') {
                    throw new TypeError(FUNC_ERROR_TEXT);
                }
                return [toIteratee(pair[0]), pair[1]];
            });

            return rest(function(args) {
                var index = -1;
                while (++index < length) {
                    var pair = pairs[index];
                    if (apply(pair[0], this, args)) {
                        return apply(pair[1], this, args);
                    }
                }
            });
        }

        /**
         * Creates a function that invokes the predicate properties of `source` with
         * the corresponding property values of a given object, returning `true` if
         * all predicates return truthy, else `false`.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Object} source The object of property predicates to conform to.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var users = [
         *   { 'user': 'barney', 'age': 36 },
         *   { 'user': 'fred',   'age': 40 }
         * ];
         *
         * _.filter(users, _.conforms({ 'age': _.partial(_.gt, _, 38) }));
         * // => [{ 'user': 'fred', 'age': 40 }]
         */
        function conforms(source) {
            return baseConforms(baseClone(source, true));
        }

        /**
         * Creates a function that returns `value`.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {*} value The value to return from the new function.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var object = { 'user': 'fred' };
         * var getter = _.constant(object);
         *
         * getter() === object;
         * // => true
         */
        function constant(value) {
            return function() {
                return value;
            };
        }

        /**
         * Creates a function that returns the result of invoking the given functions
         * with the `this` binding of the created function, where each successive
         * invocation is supplied the return value of the previous.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {...(Function|Function[])} [funcs] Functions to invoke.
         * @returns {Function} Returns the new function.
         * @example
         *
         * function square(n) {
     *   return n * n;
     * }
         *
         * var addSquare = _.flow(_.add, square);
         * addSquare(1, 2);
         * // => 9
         */
        var flow = createFlow();

        /**
         * This method is like `_.flow` except that it creates a function that
         * invokes the given functions from right to left.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {...(Function|Function[])} [funcs] Functions to invoke.
         * @returns {Function} Returns the new function.
         * @example
         *
         * function square(n) {
     *   return n * n;
     * }
         *
         * var addSquare = _.flowRight(square, _.add);
         * addSquare(1, 2);
         * // => 9
         */
        var flowRight = createFlow(true);

        /**
         * This method returns the first argument given to it.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {*} value Any value.
         * @returns {*} Returns `value`.
         * @example
         *
         * var object = { 'user': 'fred' };
         *
         * _.identity(object) === object;
         * // => true
         */
        function identity(value) {
            return value;
        }

        /**
         * Creates a function that invokes `func` with the arguments of the created
         * function. If `func` is a property name the created callback returns the
         * property value for a given element. If `func` is an object the created
         * callback returns `true` for elements that contain the equivalent object properties, otherwise it returns `false`.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {*} [func=_.identity] The value to convert to a callback.
         * @returns {Function} Returns the callback.
         * @example
         *
         * var users = [
         *   { 'user': 'barney', 'age': 36 },
         *   { 'user': 'fred',   'age': 40 }
         * ];
         *
         * // Create custom iteratee shorthands.
         * _.iteratee = _.wrap(_.iteratee, function(callback, func) {
     *   var p = /^(\S+)\s*([<>])\s*(\S+)$/.exec(func);
     *   return !p ? callback(func) : function(object) {
     *     return (p[2] == '>' ? object[p[1]] > p[3] : object[p[1]] < p[3]);
     *   };
     * });
         *
         * _.filter(users, 'age > 36');
         * // => [{ 'user': 'fred', 'age': 40 }]
         */
        function iteratee(func) {
            return baseIteratee(typeof func == 'function' ? func : baseClone(func, true));
        }

        /**
         * Creates a function that performs a deep partial comparison between a given
         * object and `source`, returning `true` if the given object has equivalent
         * property values, else `false`.
         *
         * **Note:** This method supports comparing the same values as `_.isEqual`.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Object} source The object of property values to match.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var users = [
         *   { 'user': 'barney', 'age': 36, 'active': true },
         *   { 'user': 'fred',   'age': 40, 'active': false }
         * ];
         *
         * _.filter(users, _.matches({ 'age': 40, 'active': false }));
         * // => [{ 'user': 'fred', 'age': 40, 'active': false }]
         */
        function matches(source) {
            return baseMatches(baseClone(source, true));
        }

        /**
         * Creates a function that performs a deep partial comparison between the
         * value at `path` of a given object to `srcValue`, returning `true` if the
         * object value is equivalent, else `false`.
         *
         * **Note:** This method supports comparing the same values as `_.isEqual`.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Array|string} path The path of the property to get.
         * @param {*} srcValue The value to match.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var users = [
         *   { 'user': 'barney' },
         *   { 'user': 'fred' }
         * ];
         *
         * _.find(users, _.matchesProperty('user', 'fred'));
         * // => { 'user': 'fred' }
         */
        function matchesProperty(path, srcValue) {
            return baseMatchesProperty(path, baseClone(srcValue, true));
        }

        /**
         * Creates a function that invokes the method at `path` of a given object.
         * Any additional arguments are provided to the invoked method.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Array|string} path The path of the method to invoke.
         * @param {...*} [args] The arguments to invoke the method with.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var objects = [
         *   { 'a': { 'b': { 'c': _.constant(2) } } },
         *   { 'a': { 'b': { 'c': _.constant(1) } } }
         * ];
         *
         * _.map(objects, _.method('a.b.c'));
         * // => [2, 1]
         *
         * _.invokeMap(_.sortBy(objects, _.method(['a', 'b', 'c'])), 'a.b.c');
         * // => [1, 2]
         */
        var method = rest(function(path, args) {
            return function(object) {
                return baseInvoke(object, path, args);
            };
        });

        /**
         * The opposite of `_.method`; this method creates a function that invokes
         * the method at a given path of `object`. Any additional arguments are
         * provided to the invoked method.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Object} object The object to query.
         * @param {...*} [args] The arguments to invoke the method with.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var array = _.times(3, _.constant),
         *     object = { 'a': array, 'b': array, 'c': array };
         *
         * _.map(['a[2]', 'c[0]'], _.methodOf(object));
         * // => [2, 0]
         *
         * _.map([['a', '2'], ['c', '0']], _.methodOf(object));
         * // => [2, 0]
         */
        var methodOf = rest(function(object, args) {
            return function(path) {
                return baseInvoke(object, path, args);
            };
        });

        /**
         * Adds all own enumerable function properties of a source object to the
         * destination object. If `object` is a function then methods are added to
         * its prototype as well.
         *
         * **Note:** Use `_.runInContext` to create a pristine `lodash` function to
         * avoid conflicts caused by modifying the original.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Function|Object} [object=lodash] The destination object.
         * @param {Object} source The object of functions to add.
         * @param {Object} [options] The options object.
         * @param {boolean} [options.chain=true] Specify whether the functions added
         *  are chainable.
         * @returns {Function|Object} Returns `object`.
         * @example
         *
         * function vowels(string) {
     *   return _.filter(string, function(v) {
     *     return /[aeiou]/i.test(v);
     *   });
     * }
         *
         * _.mixin({ 'vowels': vowels });
         * _.vowels('fred');
         * // => ['e']
         *
         * _('fred').vowels().value();
         * // => ['e']
         *
         * _.mixin({ 'vowels': vowels }, { 'chain': false });
         * _('fred').vowels();
         * // => ['e']
         */
        function mixin(object, source, options) {
            var props = keys(source),
                methodNames = baseFunctions(source, props);

            if (options == null &&
                !(isObject(source) && (methodNames.length || !props.length))) {
                options = source;
                source = object;
                object = this;
                methodNames = baseFunctions(source, keys(source));
            }
            var chain = (isObject(options) && 'chain' in options) ? options.chain : true,
                isFunc = isFunction(object);

            arrayEach(methodNames, function(methodName) {
                var func = source[methodName];
                object[methodName] = func;
                if (isFunc) {
                    object.prototype[methodName] = function() {
                        var chainAll = this.__chain__;
                        if (chain || chainAll) {
                            var result = object(this.__wrapped__),
                                actions = result.__actions__ = copyArray(this.__actions__);

                            actions.push({ 'func': func, 'args': arguments, 'thisArg': object });
                            result.__chain__ = chainAll;
                            return result;
                        }
                        return func.apply(object, arrayPush([this.value()], arguments));
                    };
                }
            });

            return object;
        }

        /**
         * Reverts the `_` variable to its previous value and returns a reference to
         * the `lodash` function.
         *
         * @static
         * @memberOf _
         * @category Util
         * @returns {Function} Returns the `lodash` function.
         * @example
         *
         * var lodash = _.noConflict();
         */
        function noConflict() {
            if (root._ === this) {
                root._ = oldDash;
            }
            return this;
        }

        /**
         * A no-operation function that returns `undefined` regardless of the
         * arguments it receives.
         *
         * @static
         * @memberOf _
         * @category Util
         * @example
         *
         * var object = { 'user': 'fred' };
         *
         * _.noop(object) === undefined;
         * // => true
         */
        function noop() {
            // No operation performed.
        }

        /**
         * Creates a function that returns its nth argument.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {number} [n=0] The index of the argument to return.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var func = _.nthArg(1);
         *
         * func('a', 'b', 'c');
         * // => 'b'
         */
        function nthArg(n) {
            n = toInteger(n);
            return function() {
                return arguments[n];
            };
        }

        /**
         * Creates a function that invokes `iteratees` with the arguments provided
         * to the created function and returns their results.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {...(Function|Function[])} iteratees The iteratees to invoke.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var func = _.over(Math.max, Math.min);
         *
         * func(1, 2, 3, 4);
         * // => [4, 1]
         */
        var over = createOver(arrayMap);

        /**
         * Creates a function that checks if **all** of the `predicates` return
         * truthy when invoked with the arguments provided to the created function.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {...(Function|Function[])} predicates The predicates to check.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var func = _.overEvery(Boolean, isFinite);
         *
         * func('1');
         * // => true
         *
         * func(null);
         * // => false
         *
         * func(NaN);
         * // => false
         */
        var overEvery = createOver(arrayEvery);

        /**
         * Creates a function that checks if **any** of the `predicates` return
         * truthy when invoked with the arguments provided to the created function.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {...(Function|Function[])} predicates The predicates to check.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var func = _.overSome(Boolean, isFinite);
         *
         * func('1');
         * // => true
         *
         * func(null);
         * // => true
         *
         * func(NaN);
         * // => false
         */
        var overSome = createOver(arraySome);

        /**
         * Creates a function that returns the value at `path` of a given object.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Array|string} path The path of the property to get.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var objects = [
         *   { 'a': { 'b': { 'c': 2 } } },
         *   { 'a': { 'b': { 'c': 1 } } }
         * ];
         *
         * _.map(objects, _.property('a.b.c'));
         * // => [2, 1]
         *
         * _.map(_.sortBy(objects, _.property(['a', 'b', 'c'])), 'a.b.c');
         * // => [1, 2]
         */
        function property(path) {
            return isKey(path) ? baseProperty(path) : basePropertyDeep(path);
        }

        /**
         * The opposite of `_.property`; this method creates a function that returns
         * the value at a given path of `object`.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {Object} object The object to query.
         * @returns {Function} Returns the new function.
         * @example
         *
         * var array = [0, 1, 2],
         *     object = { 'a': array, 'b': array, 'c': array };
         *
         * _.map(['a[2]', 'c[0]'], _.propertyOf(object));
         * // => [2, 0]
         *
         * _.map([['a', '2'], ['c', '0']], _.propertyOf(object));
         * // => [2, 0]
         */
        function propertyOf(object) {
            return function(path) {
                return object == null ? undefined : baseGet(object, path);
            };
        }

        /**
         * Creates an array of numbers (positive and/or negative) progressing from
         * `start` up to, but not including, `end`. A step of `-1` is used if a negative
         * `start` is specified without an `end` or `step`. If `end` is not specified
         * it's set to `start` with `start` then set to `0`.
         *
         * **Note:** JavaScript follows the IEEE-754 standard for resolving
         * floating-point values which can produce unexpected results.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {number} [start=0] The start of the range.
         * @param {number} end The end of the range.
         * @param {number} [step=1] The value to increment or decrement by.
         * @returns {Array} Returns the new array of numbers.
         * @example
         *
         * _.range(4);
         * // => [0, 1, 2, 3]
         *
         * _.range(-4);
         * // => [0, -1, -2, -3]
         *
         * _.range(1, 5);
         * // => [1, 2, 3, 4]
         *
         * _.range(0, 20, 5);
         * // => [0, 5, 10, 15]
         *
         * _.range(0, -4, -1);
         * // => [0, -1, -2, -3]
         *
         * _.range(1, 4, 0);
         * // => [1, 1, 1]
         *
         * _.range(0);
         * // => []
         */
        var range = createRange();

        /**
         * This method is like `_.range` except that it populates values in
         * descending order.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {number} [start=0] The start of the range.
         * @param {number} end The end of the range.
         * @param {number} [step=1] The value to increment or decrement by.
         * @returns {Array} Returns the new array of numbers.
         * @example
         *
         * _.rangeRight(4);
         * // => [3, 2, 1, 0]
         *
         * _.rangeRight(-4);
         * // => [-3, -2, -1, 0]
         *
         * _.rangeRight(1, 5);
         * // => [4, 3, 2, 1]
         *
         * _.rangeRight(0, 20, 5);
         * // => [15, 10, 5, 0]
         *
         * _.rangeRight(0, -4, -1);
         * // => [-3, -2, -1, 0]
         *
         * _.rangeRight(1, 4, 0);
         * // => [1, 1, 1]
         *
         * _.rangeRight(0);
         * // => []
         */
        var rangeRight = createRange(true);

        /**
         * Invokes the iteratee function `n` times, returning an array of the results
         * of each invocation. The iteratee is invoked with one argument; (index).
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {number} n The number of times to invoke `iteratee`.
         * @param {Function} [iteratee=_.identity] The function invoked per iteration.
         * @returns {Array} Returns the array of results.
         * @example
         *
         * _.times(3, String);
         * // => ['0', '1', '2']
         *
         *  _.times(4, _.constant(true));
         * // => [true, true, true, true]
         */
        function times(n, iteratee) {
            n = toInteger(n);
            if (n < 1 || n > MAX_SAFE_INTEGER) {
                return [];
            }
            var index = MAX_ARRAY_LENGTH,
                length = nativeMin(n, MAX_ARRAY_LENGTH);

            iteratee = toFunction(iteratee);
            n -= MAX_ARRAY_LENGTH;

            var result = baseTimes(length, iteratee);
            while (++index < n) {
                iteratee(index);
            }
            return result;
        }

        /**
         * Converts `value` to a property path array.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {*} value The value to convert.
         * @returns {Array} Returns the new property path array.
         * @example
         *
         * _.toPath('a.b.c');
         * // => ['a', 'b', 'c']
         *
         * _.toPath('a[0].b.c');
         * // => ['a', '0', 'b', 'c']
         *
         * var path = ['a', 'b', 'c'],
         *     newPath = _.toPath(path);
         *
         * console.log(newPath);
         * // => ['a', 'b', 'c']
         *
         * console.log(path === newPath);
         * // => false
         */
        function toPath(value) {
            return isArray(value) ? arrayMap(value, String) : stringToPath(value);
        }

        /**
         * Generates a unique ID. If `prefix` is given the ID is appended to it.
         *
         * @static
         * @memberOf _
         * @category Util
         * @param {string} [prefix] The value to prefix the ID with.
         * @returns {string} Returns the unique ID.
         * @example
         *
         * _.uniqueId('contact_');
         * // => 'contact_104'
         *
         * _.uniqueId();
         * // => '105'
         */
        function uniqueId(prefix) {
            var id = ++idCounter;
            return toString(prefix) + id;
        }

        /*------------------------------------------------------------------------*/

        /**
         * Adds two numbers.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {number} augend The first number in an addition.
         * @param {number} addend The second number in an addition.
         * @returns {number} Returns the total.
         * @example
         *
         * _.add(6, 4);
         * // => 10
         */
        function add(augend, addend) {
            var result;
            if (augend === undefined && addend === undefined) {
                return 0;
            }
            if (augend !== undefined) {
                result = augend;
            }
            if (addend !== undefined) {
                result = result === undefined ? addend : (result + addend);
            }
            return result;
        }

        /**
         * Computes `number` rounded up to `precision`.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {number} number The number to round up.
         * @param {number} [precision=0] The precision to round up to.
         * @returns {number} Returns the rounded up number.
         * @example
         *
         * _.ceil(4.006);
         * // => 5
         *
         * _.ceil(6.004, 2);
         * // => 6.01
         *
         * _.ceil(6040, -2);
         * // => 6100
         */
        var ceil = createRound('ceil');

        /**
         * Computes `number` rounded down to `precision`.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {number} number The number to round down.
         * @param {number} [precision=0] The precision to round down to.
         * @returns {number} Returns the rounded down number.
         * @example
         *
         * _.floor(4.006);
         * // => 4
         *
         * _.floor(0.046, 2);
         * // => 0.04
         *
         * _.floor(4060, -2);
         * // => 4000
         */
        var floor = createRound('floor');

        /**
         * Computes the maximum value of `array`. If `array` is empty or falsey
         * `undefined` is returned.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {Array} array The array to iterate over.
         * @returns {*} Returns the maximum value.
         * @example
         *
         * _.max([4, 2, 8, 6]);
         * // => 8
         *
         * _.max([]);
         * // => undefined
         */
        function max(array) {
            return (array && array.length)
                ? baseExtremum(array, identity, gt)
                : undefined;
        }

        /**
         * This method is like `_.max` except that it accepts `iteratee` which is
         * invoked for each element in `array` to generate the criterion by which
         * the value is ranked. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {Array} array The array to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {*} Returns the maximum value.
         * @example
         *
         * var objects = [{ 'n': 1 }, { 'n': 2 }];
         *
         * _.maxBy(objects, function(o) { return o.n; });
         * // => { 'n': 2 }
         *
         * // The `_.property` iteratee shorthand.
         * _.maxBy(objects, 'n');
         * // => { 'n': 2 }
         */
        function maxBy(array, iteratee) {
            return (array && array.length)
                ? baseExtremum(array, getIteratee(iteratee), gt)
                : undefined;
        }

        /**
         * Computes the mean of the values in `array`.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {Array} array The array to iterate over.
         * @returns {number} Returns the mean.
         * @example
         *
         * _.mean([4, 2, 8, 6]);
         * // => 5
         */
        function mean(array) {
            return sum(array) / (array ? array.length : 0);
        }

        /**
         * Computes the minimum value of `array`. If `array` is empty or falsey
         * `undefined` is returned.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {Array} array The array to iterate over.
         * @returns {*} Returns the minimum value.
         * @example
         *
         * _.min([4, 2, 8, 6]);
         * // => 2
         *
         * _.min([]);
         * // => undefined
         */
        function min(array) {
            return (array && array.length)
                ? baseExtremum(array, identity, lt)
                : undefined;
        }

        /**
         * This method is like `_.min` except that it accepts `iteratee` which is
         * invoked for each element in `array` to generate the criterion by which
         * the value is ranked. The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {Array} array The array to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {*} Returns the minimum value.
         * @example
         *
         * var objects = [{ 'n': 1 }, { 'n': 2 }];
         *
         * _.minBy(objects, function(o) { return o.n; });
         * // => { 'n': 1 }
         *
         * // The `_.property` iteratee shorthand.
         * _.minBy(objects, 'n');
         * // => { 'n': 1 }
         */
        function minBy(array, iteratee) {
            return (array && array.length)
                ? baseExtremum(array, getIteratee(iteratee), lt)
                : undefined;
        }

        /**
         * Computes `number` rounded to `precision`.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {number} number The number to round.
         * @param {number} [precision=0] The precision to round to.
         * @returns {number} Returns the rounded number.
         * @example
         *
         * _.round(4.006);
         * // => 4
         *
         * _.round(4.006, 2);
         * // => 4.01
         *
         * _.round(4060, -2);
         * // => 4100
         */
        var round = createRound('round');

        /**
         * Subtract two numbers.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {number} minuend The first number in a subtraction.
         * @param {number} subtrahend The second number in a subtraction.
         * @returns {number} Returns the difference.
         * @example
         *
         * _.subtract(6, 4);
         * // => 2
         */
        function subtract(minuend, subtrahend) {
            var result;
            if (minuend === undefined && subtrahend === undefined) {
                return 0;
            }
            if (minuend !== undefined) {
                result = minuend;
            }
            if (subtrahend !== undefined) {
                result = result === undefined ? subtrahend : (result - subtrahend);
            }
            return result;
        }

        /**
         * Computes the sum of the values in `array`.
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {Array} array The array to iterate over.
         * @returns {number} Returns the sum.
         * @example
         *
         * _.sum([4, 2, 8, 6]);
         * // => 20
         */
        function sum(array) {
            return (array && array.length)
                ? baseSum(array, identity)
                : 0;
        }

        /**
         * This method is like `_.sum` except that it accepts `iteratee` which is
         * invoked for each element in `array` to generate the value to be summed.
         * The iteratee is invoked with one argument: (value).
         *
         * @static
         * @memberOf _
         * @category Math
         * @param {Array} array The array to iterate over.
         * @param {Function|Object|string} [iteratee=_.identity] The iteratee invoked per element.
         * @returns {number} Returns the sum.
         * @example
         *
         * var objects = [{ 'n': 4 }, { 'n': 2 }, { 'n': 8 }, { 'n': 6 }];
         *
         * _.sumBy(objects, function(o) { return o.n; });
         * // => 20
         *
         * // The `_.property` iteratee shorthand.
         * _.sumBy(objects, 'n');
         * // => 20
         */
        function sumBy(array, iteratee) {
            return (array && array.length)
                ? baseSum(array, getIteratee(iteratee))
                : 0;
        }

        /*------------------------------------------------------------------------*/

        // Ensure wrappers are instances of `baseLodash`.
        lodash.prototype = baseLodash.prototype;

        LodashWrapper.prototype = baseCreate(baseLodash.prototype);
        LodashWrapper.prototype.constructor = LodashWrapper;

        LazyWrapper.prototype = baseCreate(baseLodash.prototype);
        LazyWrapper.prototype.constructor = LazyWrapper;

        // Avoid inheriting from `Object.prototype` when possible.
        Hash.prototype = nativeCreate ? nativeCreate(null) : objectProto;

        // Add functions to the `MapCache`.
        MapCache.prototype.clear = mapClear;
        MapCache.prototype['delete'] = mapDelete;
        MapCache.prototype.get = mapGet;
        MapCache.prototype.has = mapHas;
        MapCache.prototype.set = mapSet;

        // Add functions to the `SetCache`.
        SetCache.prototype.push = cachePush;

        // Add functions to the `Stack` cache.
        Stack.prototype.clear = stackClear;
        Stack.prototype['delete'] = stackDelete;
        Stack.prototype.get = stackGet;
        Stack.prototype.has = stackHas;
        Stack.prototype.set = stackSet;

        // Assign cache to `_.memoize`.
        memoize.Cache = MapCache;

        // Add functions that return wrapped values when chaining.
        lodash.after = after;
        lodash.ary = ary;
        lodash.assign = assign;
        lodash.assignIn = assignIn;
        lodash.assignInWith = assignInWith;
        lodash.assignWith = assignWith;
        lodash.at = at;
        lodash.before = before;
        lodash.bind = bind;
        lodash.bindAll = bindAll;
        lodash.bindKey = bindKey;
        lodash.chain = chain;
        lodash.chunk = chunk;
        lodash.compact = compact;
        lodash.concat = concat;
        lodash.cond = cond;
        lodash.conforms = conforms;
        lodash.constant = constant;
        lodash.countBy = countBy;
        lodash.create = create;
        lodash.curry = curry;
        lodash.curryRight = curryRight;
        lodash.debounce = debounce;
        lodash.defaults = defaults;
        lodash.defaultsDeep = defaultsDeep;
        lodash.defer = defer;
        lodash.delay = delay;
        lodash.difference = difference;
        lodash.differenceBy = differenceBy;
        lodash.differenceWith = differenceWith;
        lodash.drop = drop;
        lodash.dropRight = dropRight;
        lodash.dropRightWhile = dropRightWhile;
        lodash.dropWhile = dropWhile;
        lodash.fill = fill;
        lodash.filter = filter;
        lodash.flatMap = flatMap;
        lodash.flatten = flatten;
        lodash.flattenDeep = flattenDeep;
        lodash.flip = flip;
        lodash.flow = flow;
        lodash.flowRight = flowRight;
        lodash.fromPairs = fromPairs;
        lodash.functions = functions;
        lodash.functionsIn = functionsIn;
        lodash.groupBy = groupBy;
        lodash.initial = initial;
        lodash.intersection = intersection;
        lodash.intersectionBy = intersectionBy;
        lodash.intersectionWith = intersectionWith;
        lodash.invert = invert;
        lodash.invertBy = invertBy;
        lodash.invokeMap = invokeMap;
        lodash.iteratee = iteratee;
        lodash.keyBy = keyBy;
        lodash.keys = keys;
        lodash.keysIn = keysIn;
        lodash.map = map;
        lodash.mapKeys = mapKeys;
        lodash.mapValues = mapValues;
        lodash.matches = matches;
        lodash.matchesProperty = matchesProperty;
        lodash.memoize = memoize;
        lodash.merge = merge;
        lodash.mergeWith = mergeWith;
        lodash.method = method;
        lodash.methodOf = methodOf;
        lodash.mixin = mixin;
        lodash.negate = negate;
        lodash.nthArg = nthArg;
        lodash.omit = omit;
        lodash.omitBy = omitBy;
        lodash.once = once;
        lodash.orderBy = orderBy;
        lodash.over = over;
        lodash.overArgs = overArgs;
        lodash.overEvery = overEvery;
        lodash.overSome = overSome;
        lodash.partial = partial;
        lodash.partialRight = partialRight;
        lodash.partition = partition;
        lodash.pick = pick;
        lodash.pickBy = pickBy;
        lodash.property = property;
        lodash.propertyOf = propertyOf;
        lodash.pull = pull;
        lodash.pullAll = pullAll;
        lodash.pullAllBy = pullAllBy;
        lodash.pullAt = pullAt;
        lodash.range = range;
        lodash.rangeRight = rangeRight;
        lodash.rearg = rearg;
        lodash.reject = reject;
        lodash.remove = remove;
        lodash.rest = rest;
        lodash.reverse = reverse;
        lodash.sampleSize = sampleSize;
        lodash.set = set;
        lodash.setWith = setWith;
        lodash.shuffle = shuffle;
        lodash.slice = slice;
        lodash.sortBy = sortBy;
        lodash.sortedUniq = sortedUniq;
        lodash.sortedUniqBy = sortedUniqBy;
        lodash.split = split;
        lodash.spread = spread;
        lodash.tail = tail;
        lodash.take = take;
        lodash.takeRight = takeRight;
        lodash.takeRightWhile = takeRightWhile;
        lodash.takeWhile = takeWhile;
        lodash.tap = tap;
        lodash.throttle = throttle;
        lodash.thru = thru;
        lodash.toArray = toArray;
        lodash.toPairs = toPairs;
        lodash.toPairsIn = toPairsIn;
        lodash.toPath = toPath;
        lodash.toPlainObject = toPlainObject;
        lodash.transform = transform;
        lodash.unary = unary;
        lodash.union = union;
        lodash.unionBy = unionBy;
        lodash.unionWith = unionWith;
        lodash.uniq = uniq;
        lodash.uniqBy = uniqBy;
        lodash.uniqWith = uniqWith;
        lodash.unset = unset;
        lodash.unzip = unzip;
        lodash.unzipWith = unzipWith;
        lodash.values = values;
        lodash.valuesIn = valuesIn;
        lodash.without = without;
        lodash.words = words;
        lodash.wrap = wrap;
        lodash.xor = xor;
        lodash.xorBy = xorBy;
        lodash.xorWith = xorWith;
        lodash.zip = zip;
        lodash.zipObject = zipObject;
        lodash.zipObjectDeep = zipObjectDeep;
        lodash.zipWith = zipWith;

        // Add aliases.
        lodash.extend = assignIn;
        lodash.extendWith = assignInWith;

        // Add functions to `lodash.prototype`.
        mixin(lodash, lodash);

        /*------------------------------------------------------------------------*/

        // Add functions that return unwrapped values when chaining.
        lodash.add = add;
        lodash.attempt = attempt;
        lodash.camelCase = camelCase;
        lodash.capitalize = capitalize;
        lodash.ceil = ceil;
        lodash.clamp = clamp;
        lodash.clone = clone;
        lodash.cloneDeep = cloneDeep;
        lodash.cloneDeepWith = cloneDeepWith;
        lodash.cloneWith = cloneWith;
        lodash.deburr = deburr;
        lodash.endsWith = endsWith;
        lodash.eq = eq;
        lodash.escape = escape;
        lodash.escapeRegExp = escapeRegExp;
        lodash.every = every;
        lodash.find = find;
        lodash.findIndex = findIndex;
        lodash.findKey = findKey;
        lodash.findLast = findLast;
        lodash.findLastIndex = findLastIndex;
        lodash.findLastKey = findLastKey;
        lodash.floor = floor;
        lodash.forEach = forEach;
        lodash.forEachRight = forEachRight;
        lodash.forIn = forIn;
        lodash.forInRight = forInRight;
        lodash.forOwn = forOwn;
        lodash.forOwnRight = forOwnRight;
        lodash.get = get;
        lodash.gt = gt;
        lodash.gte = gte;
        lodash.has = has;
        lodash.hasIn = hasIn;
        lodash.head = head;
        lodash.identity = identity;
        lodash.includes = includes;
        lodash.indexOf = indexOf;
        lodash.inRange = inRange;
        lodash.invoke = invoke;
        lodash.isArguments = isArguments;
        lodash.isArray = isArray;
        lodash.isArrayBuffer = isArrayBuffer;
        lodash.isArrayLike = isArrayLike;
        lodash.isArrayLikeObject = isArrayLikeObject;
        lodash.isBoolean = isBoolean;
        lodash.isBuffer = isBuffer;
        lodash.isDate = isDate;
        lodash.isElement = isElement;
        lodash.isEmpty = isEmpty;
        lodash.isEqual = isEqual;
        lodash.isEqualWith = isEqualWith;
        lodash.isError = isError;
        lodash.isFinite = isFinite;
        lodash.isFunction = isFunction;
        lodash.isInteger = isInteger;
        lodash.isLength = isLength;
        lodash.isMap = isMap;
        lodash.isMatch = isMatch;
        lodash.isMatchWith = isMatchWith;
        lodash.isNaN = isNaN;
        lodash.isNative = isNative;
        lodash.isNil = isNil;
        lodash.isNull = isNull;
        lodash.isNumber = isNumber;
        lodash.isObject = isObject;
        lodash.isObjectLike = isObjectLike;
        lodash.isPlainObject = isPlainObject;
        lodash.isRegExp = isRegExp;
        lodash.isSafeInteger = isSafeInteger;
        lodash.isSet = isSet;
        lodash.isString = isString;
        lodash.isSymbol = isSymbol;
        lodash.isTypedArray = isTypedArray;
        lodash.isUndefined = isUndefined;
        lodash.isWeakMap = isWeakMap;
        lodash.isWeakSet = isWeakSet;
        lodash.join = join;
        lodash.kebabCase = kebabCase;
        lodash.last = last;
        lodash.lastIndexOf = lastIndexOf;
        lodash.lowerCase = lowerCase;
        lodash.lowerFirst = lowerFirst;
        lodash.lt = lt;
        lodash.lte = lte;
        lodash.max = max;
        lodash.maxBy = maxBy;
        lodash.mean = mean;
        lodash.min = min;
        lodash.minBy = minBy;
        lodash.noConflict = noConflict;
        lodash.noop = noop;
        lodash.now = now;
        lodash.pad = pad;
        lodash.padEnd = padEnd;
        lodash.padStart = padStart;
        lodash.parseInt = parseInt;
        lodash.random = random;
        lodash.reduce = reduce;
        lodash.reduceRight = reduceRight;
        lodash.repeat = repeat;
        lodash.replace = replace;
        lodash.result = result;
        lodash.round = round;
        lodash.runInContext = runInContext;
        lodash.sample = sample;
        lodash.size = size;
        lodash.snakeCase = snakeCase;
        lodash.some = some;
        lodash.sortedIndex = sortedIndex;
        lodash.sortedIndexBy = sortedIndexBy;
        lodash.sortedIndexOf = sortedIndexOf;
        lodash.sortedLastIndex = sortedLastIndex;
        lodash.sortedLastIndexBy = sortedLastIndexBy;
        lodash.sortedLastIndexOf = sortedLastIndexOf;
        lodash.startCase = startCase;
        lodash.startsWith = startsWith;
        lodash.subtract = subtract;
        lodash.sum = sum;
        lodash.sumBy = sumBy;
        lodash.template = template;
        lodash.times = times;
        lodash.toInteger = toInteger;
        lodash.toLength = toLength;
        lodash.toLower = toLower;
        lodash.toNumber = toNumber;
        lodash.toSafeInteger = toSafeInteger;
        lodash.toString = toString;
        lodash.toUpper = toUpper;
        lodash.trim = trim;
        lodash.trimEnd = trimEnd;
        lodash.trimStart = trimStart;
        lodash.truncate = truncate;
        lodash.unescape = unescape;
        lodash.uniqueId = uniqueId;
        lodash.upperCase = upperCase;
        lodash.upperFirst = upperFirst;

        // Add aliases.
        lodash.each = forEach;
        lodash.eachRight = forEachRight;
        lodash.first = head;

        mixin(lodash, (function() {
            var source = {};
            baseForOwn(lodash, function(func, methodName) {
                if (!hasOwnProperty.call(lodash.prototype, methodName)) {
                    source[methodName] = func;
                }
            });
            return source;
        }()), { 'chain': false });

        /*------------------------------------------------------------------------*/

        /**
         * The semantic version number.
         *
         * @static
         * @memberOf _
         * @type string
         */
        lodash.VERSION = VERSION;

        // Assign default placeholders.
        arrayEach(['bind', 'bindKey', 'curry', 'curryRight', 'partial', 'partialRight'], function(methodName) {
            lodash[methodName].placeholder = lodash;
        });

        // Add `LazyWrapper` methods for `_.drop` and `_.take` variants.
        arrayEach(['drop', 'take'], function(methodName, index) {
            LazyWrapper.prototype[methodName] = function(n) {
                var filtered = this.__filtered__;
                if (filtered && !index) {
                    return new LazyWrapper(this);
                }
                n = n === undefined ? 1 : nativeMax(toInteger(n), 0);

                var result = this.clone();
                if (filtered) {
                    result.__takeCount__ = nativeMin(n, result.__takeCount__);
                } else {
                    result.__views__.push({ 'size': nativeMin(n, MAX_ARRAY_LENGTH), 'type': methodName + (result.__dir__ < 0 ? 'Right' : '') });
                }
                return result;
            };

            LazyWrapper.prototype[methodName + 'Right'] = function(n) {
                return this.reverse()[methodName](n).reverse();
            };
        });

        // Add `LazyWrapper` methods that accept an `iteratee` value.
        arrayEach(['filter', 'map', 'takeWhile'], function(methodName, index) {
            var type = index + 1,
                isFilter = type == LAZY_FILTER_FLAG || type == LAZY_WHILE_FLAG;

            LazyWrapper.prototype[methodName] = function(iteratee) {
                var result = this.clone();
                result.__iteratees__.push({ 'iteratee': getIteratee(iteratee, 3), 'type': type });
                result.__filtered__ = result.__filtered__ || isFilter;
                return result;
            };
        });

        // Add `LazyWrapper` methods for `_.head` and `_.last`.
        arrayEach(['head', 'last'], function(methodName, index) {
            var takeName = 'take' + (index ? 'Right' : '');

            LazyWrapper.prototype[methodName] = function() {
                return this[takeName](1).value()[0];
            };
        });

        // Add `LazyWrapper` methods for `_.initial` and `_.tail`.
        arrayEach(['initial', 'tail'], function(methodName, index) {
            var dropName = 'drop' + (index ? '' : 'Right');

            LazyWrapper.prototype[methodName] = function() {
                return this.__filtered__ ? new LazyWrapper(this) : this[dropName](1);
            };
        });

        LazyWrapper.prototype.compact = function() {
            return this.filter(identity);
        };

        LazyWrapper.prototype.find = function(predicate) {
            return this.filter(predicate).head();
        };

        LazyWrapper.prototype.findLast = function(predicate) {
            return this.reverse().find(predicate);
        };

        LazyWrapper.prototype.invokeMap = rest(function(path, args) {
            if (typeof path == 'function') {
                return new LazyWrapper(this);
            }
            return this.map(function(value) {
                return baseInvoke(value, path, args);
            });
        });

        LazyWrapper.prototype.reject = function(predicate) {
            predicate = getIteratee(predicate, 3);
            return this.filter(function(value) {
                return !predicate(value);
            });
        };

        LazyWrapper.prototype.slice = function(start, end) {
            start = toInteger(start);

            var result = this;
            if (result.__filtered__ && (start > 0 || end < 0)) {
                return new LazyWrapper(result);
            }
            if (start < 0) {
                result = result.takeRight(-start);
            } else if (start) {
                result = result.drop(start);
            }
            if (end !== undefined) {
                end = toInteger(end);
                result = end < 0 ? result.dropRight(-end) : result.take(end - start);
            }
            return result;
        };

        LazyWrapper.prototype.takeRightWhile = function(predicate) {
            return this.reverse().takeWhile(predicate).reverse();
        };

        LazyWrapper.prototype.toArray = function() {
            return this.take(MAX_ARRAY_LENGTH);
        };

        // Add `LazyWrapper` methods to `lodash.prototype`.
        baseForOwn(LazyWrapper.prototype, function(func, methodName) {
            var checkIteratee = /^(?:filter|find|map|reject)|While$/.test(methodName),
                isTaker = /^(?:head|last)$/.test(methodName),
                lodashFunc = lodash[isTaker ? ('take' + (methodName == 'last' ? 'Right' : '')) : methodName],
                retUnwrapped = isTaker || /^find/.test(methodName);

            if (!lodashFunc) {
                return;
            }
            lodash.prototype[methodName] = function() {
                var value = this.__wrapped__,
                    args = isTaker ? [1] : arguments,
                    isLazy = value instanceof LazyWrapper,
                    iteratee = args[0],
                    useLazy = isLazy || isArray(value);

                var interceptor = function(value) {
                    var result = lodashFunc.apply(lodash, arrayPush([value], args));
                    return (isTaker && chainAll) ? result[0] : result;
                };

                if (useLazy && checkIteratee && typeof iteratee == 'function' && iteratee.length != 1) {
                    // Avoid lazy use if the iteratee has a "length" value other than `1`.
                    isLazy = useLazy = false;
                }
                var chainAll = this.__chain__,
                    isHybrid = !!this.__actions__.length,
                    isUnwrapped = retUnwrapped && !chainAll,
                    onlyLazy = isLazy && !isHybrid;

                if (!retUnwrapped && useLazy) {
                    value = onlyLazy ? value : new LazyWrapper(this);
                    var result = func.apply(value, args);
                    result.__actions__.push({ 'func': thru, 'args': [interceptor], 'thisArg': undefined });
                    return new LodashWrapper(result, chainAll);
                }
                if (isUnwrapped && onlyLazy) {
                    return func.apply(this, args);
                }
                result = this.thru(interceptor);
                return isUnwrapped ? (isTaker ? result.value()[0] : result.value()) : result;
            };
        });

        // Add `Array` and `String` methods to `lodash.prototype`.
        arrayEach(['pop', 'push', 'shift', 'sort', 'splice', 'unshift'], function(methodName) {
            var func = arrayProto[methodName],
                chainName = /^(?:push|sort|unshift)$/.test(methodName) ? 'tap' : 'thru',
                retUnwrapped = /^(?:pop|shift)$/.test(methodName);

            lodash.prototype[methodName] = function() {
                var args = arguments;
                if (retUnwrapped && !this.__chain__) {
                    return func.apply(this.value(), args);
                }
                return this[chainName](function(value) {
                    return func.apply(value, args);
                });
            };
        });

        // Map minified function names to their real names.
        baseForOwn(LazyWrapper.prototype, function(func, methodName) {
            var lodashFunc = lodash[methodName];
            if (lodashFunc) {
                var key = (lodashFunc.name + ''),
                    names = realNames[key] || (realNames[key] = []);

                names.push({ 'name': methodName, 'func': lodashFunc });
            }
        });

        realNames[createHybridWrapper(undefined, BIND_KEY_FLAG).name] = [{ 'name': 'wrapper', 'func': undefined }];

        // Add functions to the lazy wrapper.
        LazyWrapper.prototype.clone = lazyClone;
        LazyWrapper.prototype.reverse = lazyReverse;
        LazyWrapper.prototype.value = lazyValue;

        // Add chaining functions to the `lodash` wrapper.
        lodash.prototype.at = wrapperAt;
        lodash.prototype.chain = wrapperChain;
        lodash.prototype.commit = wrapperCommit;
        lodash.prototype.flatMap = wrapperFlatMap;
        lodash.prototype.next = wrapperNext;
        lodash.prototype.plant = wrapperPlant;
        lodash.prototype.reverse = wrapperReverse;
        lodash.prototype.toJSON = lodash.prototype.valueOf = lodash.prototype.value = wrapperValue;

        if (iteratorSymbol) {
            lodash.prototype[iteratorSymbol] = wrapperToIterator;
        }
        return lodash;
    }

    /*--------------------------------------------------------------------------*/

    // Export lodash.
    var _ = runInContext();

    // Expose lodash on the free variable `window` or `self` when available. This
    // prevents errors in cases where lodash is loaded by a script tag in the presence
    // of an AMD loader. See http://requirejs.org/docs/errors.html#mismatch for more details.
    (freeWindow || freeSelf || {})._ = _;

    // Some AMD build optimizers like r.js check for condition patterns like the following:
    if (typeof define == 'function' && typeof define.amd == 'object' && define.amd) {
        // Define as an anonymous module so, through path mapping, it can be
        // referenced as the "underscore" module.
        define(function() {
            return _;
        });
    }
    // Check for `exports` after `define` in case a build optimizer adds an `exports` object.
    else if (freeExports && freeModule) {
        // Export for Node.js.
        if (moduleExports) {
            (freeModule.exports = _)._ = _;
        }
        // Export for CommonJS support.
        freeExports._ = _;
    }
    else {
        // Export to the global object.
        root._ = _;
    }
}.call(this));



!function ($) {
    'use strict';

    // BUTTON PUBLIC CLASS DEFINITION
    // ==============================

    var Button = function (element, options) {
        this.$element  = $(element)
        this.options   = $.extend({}, Button.DEFAULTS, options)
        this.isLoading = false
    };

    Button.VERSION  = '3.3.6'

    Button.DEFAULTS = {
        loadingText: 'loading...'
    };

    Button.prototype.setState = function (state) {
        var d    = 'disabled'
        var $el  = this.$element
        var val  = $el.is('input') ? 'val' : 'html'
        var data = $el.data()

        state += 'Text'

        if (data.resetText == null) $el.data('resetText', $el[val]())

        // push to event loop to allow forms to submit
        setTimeout($.proxy(function () {
            $el[val](data[state] == null ? this.options[state] : data[state])

            if (state == 'loadingText') {
                this.isLoading = true
                $el.addClass(d).attr(d, d)
            } else if (this.isLoading) {
                this.isLoading = false
                $el.removeClass(d).removeAttr(d)
            }
        }, this), 0)
    }

    Button.prototype.toggle = function () {
        var changed = true
        var $parent = this.$element.closest('[data-toggle="buttons"]')

        if ($parent.length) {
            var $input = this.$element.find('input')
            if ($input.prop('type') == 'radio') {
                if ($input.prop('checked')) changed = false
                $parent.find('.active').removeClass('active')
                this.$element.addClass('active')
            } else if ($input.prop('type') == 'checkbox') {
                if (($input.prop('checked')) !== this.$element.hasClass('active')) changed = false
                this.$element.toggleClass('active')
            }
            $input.prop('checked', this.$element.hasClass('active'))
            if (changed) $input.trigger('change')
        } else {
            this.$element.attr('aria-pressed', !this.$element.hasClass('active'))
            this.$element.toggleClass('active')
        }
    }


    // BUTTON PLUGIN DEFINITION
    // ========================

    function Plugin(option) {
        return this.each(function () {
            var $this   = $(this)
            var data    = $this.data('bs.button')
            var options = typeof option == 'object' && option

            if (!data) $this.data('bs.button', (data = new Button(this, options)))

            if (option == 'toggle') data.toggle()
            else if (option) data.setState(option)
        })
    }

    var old = $.fn.button

    $.fn.button             = Plugin
    $.fn.button.Constructor = Button


    // BUTTON NO CONFLICT
    // ==================

    $.fn.button.noConflict = function () {
        $.fn.button = old
        return this
    }


    // BUTTON DATA-API
    // ===============

    $(document)
        .on('click.bs.button.data-api', '[data-toggle^="button"]', function (e) {
            var $btn = $(e.target).closest('.btn')
            Plugin.call($btn, 'toggle')
            if (!($(e.target).is('input[type="radio"]') || $(e.target).is('input[type="checkbox"]'))) {
                // Prevent double click on radios, and the double selections (so cancellation) on checkboxes
                e.preventDefault()
                // The target component still receive the focus
                if ($btn.is('input,button')) $btn.trigger('focus')
                else $btn.find('input:visible,button:visible').first().trigger('focus')
            }
        })
        .on('focus.bs.button.data-api blur.bs.button.data-api', '[data-toggle^="button"]', function (e) {
            $(e.target).closest('.btn').toggleClass('focus', /^focus(in)?$/.test(e.type))
        })

}(jQuery);

/*
 jQuery Masked Input Plugin
 Copyright (c) 2007 - 2015 Josh Bush (digitalbush.com)
 Licensed under the MIT license (http://digitalbush.com/projects/masked-input-plugin/#license)
 Version: 1.4.1
 */
!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):a("object"==typeof exports?require("jquery"):jQuery)}(function(a){var b,c=navigator.userAgent,d=/iphone/i.test(c),e=/chrome/i.test(c),f=/android/i.test(c);a.mask={definitions:{9:"[0-9]",a:"[A-Za-z]","*":"[A-Za-z0-9]"},autoclear:!0,dataName:"rawMaskFn",placeholder:"_"},a.fn.extend({caret:function(a,b){var c;if(0!==this.length&&!this.is(":hidden"))return"number"==typeof a?(b="number"==typeof b?b:a,this.each(function(){this.setSelectionRange?this.setSelectionRange(a,b):this.createTextRange&&(c=this.createTextRange(),c.collapse(!0),c.moveEnd("character",b),c.moveStart("character",a),c.select())})):(this[0].setSelectionRange?(a=this[0].selectionStart,b=this[0].selectionEnd):document.selection&&document.selection.createRange&&(c=document.selection.createRange(),a=0-c.duplicate().moveStart("character",-1e5),b=a+c.text.length),{begin:a,end:b})},unmask:function(){return this.trigger("unmask")},mask:function(c,g){var h,i,j,k,l,m,n,o;if(!c&&this.length>0){h=a(this[0]);var p=h.data(a.mask.dataName);return p?p():void 0}return g=a.extend({autoclear:a.mask.autoclear,placeholder:a.mask.placeholder,completed:null},g),i=a.mask.definitions,j=[],k=n=c.length,l=null,a.each(c.split(""),function(a,b){"?"==b?(n--,k=a):i[b]?(j.push(new RegExp(i[b])),null===l&&(l=j.length-1),k>a&&(m=j.length-1)):j.push(null)}),this.trigger("unmask").each(function(){function h(){if(g.completed){for(var a=l;m>=a;a++)if(j[a]&&C[a]===p(a))return;g.completed.call(B)}}function p(a){return g.placeholder.charAt(a<g.placeholder.length?a:0)}function q(a){for(;++a<n&&!j[a];);return a}function r(a){for(;--a>=0&&!j[a];);return a}function s(a,b){var c,d;if(!(0>a)){for(c=a,d=q(b);n>c;c++)if(j[c]){if(!(n>d&&j[c].test(C[d])))break;C[c]=C[d],C[d]=p(d),d=q(d)}z(),B.caret(Math.max(l,a))}}function t(a){var b,c,d,e;for(b=a,c=p(a);n>b;b++)if(j[b]){if(d=q(b),e=C[b],C[b]=c,!(n>d&&j[d].test(e)))break;c=e}}function u(){var a=B.val(),b=B.caret();if(o&&o.length&&o.length>a.length){for(A(!0);b.begin>0&&!j[b.begin-1];)b.begin--;if(0===b.begin)for(;b.begin<l&&!j[b.begin];)b.begin++;B.caret(b.begin,b.begin)}else{for(A(!0);b.begin<n&&!j[b.begin];)b.begin++;B.caret(b.begin,b.begin)}h()}function v(){A(),B.val()!=E&&B.change()}function w(a){if(!B.prop("readonly")){var b,c,e,f=a.which||a.keyCode;o=B.val(),8===f||46===f||d&&127===f?(b=B.caret(),c=b.begin,e=b.end,e-c===0&&(c=46!==f?r(c):e=q(c-1),e=46===f?q(e):e),y(c,e),s(c,e-1),a.preventDefault()):13===f?v.call(this,a):27===f&&(B.val(E),B.caret(0,A()),a.preventDefault())}}function x(b){if(!B.prop("readonly")){var c,d,e,g=b.which||b.keyCode,i=B.caret();if(!(b.ctrlKey||b.altKey||b.metaKey||32>g)&&g&&13!==g){if(i.end-i.begin!==0&&(y(i.begin,i.end),s(i.begin,i.end-1)),c=q(i.begin-1),n>c&&(d=String.fromCharCode(g),j[c].test(d))){if(t(c),C[c]=d,z(),e=q(c),f){var k=function(){a.proxy(a.fn.caret,B,e)()};setTimeout(k,0)}else B.caret(e);i.begin<=m&&h()}b.preventDefault()}}}function y(a,b){var c;for(c=a;b>c&&n>c;c++)j[c]&&(C[c]=p(c))}function z(){B.val(C.join(""))}function A(a){var b,c,d,e=B.val(),f=-1;for(b=0,d=0;n>b;b++)if(j[b]){for(C[b]=p(b);d++<e.length;)if(c=e.charAt(d-1),j[b].test(c)){C[b]=c,f=b;break}if(d>e.length){y(b+1,n);break}}else C[b]===e.charAt(d)&&d++,k>b&&(f=b);return a?z():k>f+1?g.autoclear||C.join("")===D?(B.val()&&B.val(""),y(0,n)):z():(z(),B.val(B.val().substring(0,f+1))),k?b:l}var B=a(this),C=a.map(c.split(""),function(a,b){return"?"!=a?i[a]?p(b):a:void 0}),D=C.join(""),E=B.val();B.data(a.mask.dataName,function(){return a.map(C,function(a,b){return j[b]&&a!=p(b)?a:null}).join("")}),B.one("unmask",function(){B.off(".mask").removeData(a.mask.dataName)}).on("focus.mask",function(){if(!B.prop("readonly")){clearTimeout(b);var a;E=B.val(),a=A(),b=setTimeout(function(){B.get(0)===document.activeElement&&(z(),a==c.replace("?","").length?B.caret(0,a):B.caret(a))},10)}}).on("blur.mask",v).on("keydown.mask",w).on("keypress.mask",x).on("input.mask paste.mask",function(){B.prop("readonly")||setTimeout(function(){var a=A(!0);B.caret(a),h()},0)}),e&&f&&B.off("input.mask").on("input.mask",u),A()})}})});
(function(e){typeof define=="function"&&define.amd?define(["jquery"],e):typeof module=="object"&&module.exports?module.exports=function(t,n){return n===undefined&&(typeof window!="undefined"?n=require("jquery"):n=require("jquery")(t)),e(n),n}:e(jQuery)})(function(e){function L(t,n,i){typeof i=="string"&&(i={className:i}),this.options=w(b,e.isPlainObject(i)?i:{}),this.loadHTML(),this.wrapper=e(h.html),this.options.clickToHide&&this.wrapper.addClass(r+"-hidable"),this.wrapper.data(r,this),this.arrow=this.wrapper.find("."+r+"-arrow"),this.container=this.wrapper.find("."+r+"-container"),this.container.append(this.userContainer),t&&t.length&&(this.elementType=t.attr("type"),this.originalElement=t,this.elem=T(t),this.elem.data(r,this),this.elem.before(this.wrapper)),this.container.hide(),this.run(n)}var t=[].indexOf||function(e){for(var t=0,n=this.length;t<n;t++)if(t in this&&this[t]===e)return t;return-1},n="notify",r=n+"js",i=n+"!blank",s={t:"top",m:"middle",b:"bottom",l:"left",c:"center",r:"right"},o=["l","c","r"],u=["t","m","b"],a=["t","b","l","r"],f={t:"b",m:null,b:"t",l:"r",c:null,r:"l"},l=function(t){var n;return n=[],e.each(t.split(/\W+/),function(e,t){var r;r=t.toLowerCase().charAt(0);if(s[r])return n.push(r)}),n},c={},h={name:"core",html:'<div class="'+r+'-wrapper">\n	<div class="'+r+'-arrow"></div>\n	<div class="'+r+'-container"></div>\n</div>',css:"."+r+"-corner {\n	position: fixed;\n	margin: 5px;\n	z-index: 1050;\n}\n\n."+r+"-corner ."+r+"-wrapper,\n."+r+"-corner ."+r+"-container {\n	position: relative;\n	display: block;\n	height: inherit;\n	width: inherit;\n	margin: 3px;\n}\n\n."+r+"-wrapper {\n	z-index: 1;\n	position: absolute;\n	display: inline-block;\n	height: 0;\n	width: 0;\n}\n\n."+r+"-container {\n	display: none;\n	z-index: 1;\n	position: absolute;\n}\n\n."+r+"-hidable {\n	cursor: pointer;\n}\n\n[data-notify-text],[data-notify-html] {\n	position: relative;\n}\n\n."+r+"-arrow {\n	position: absolute;\n	z-index: 2;\n	width: 0;\n	height: 0;\n}"},p={"border-radius":["-webkit-","-moz-"]},d=function(e){return c[e]},v=function(t,i){if(!t)throw"Missing Style name";if(!i)throw"Missing Style definition";if(!i.html)throw"Missing Style HTML";var s=c[t];s&&s.cssElem&&(window.console&&console.warn(n+": overwriting style '"+t+"'"),c[t].cssElem.remove()),i.name=t,c[t]=i;var o="";i.classes&&e.each(i.classes,function(t,n){return o+="."+r+"-"+i.name+"-"+t+" {\n",e.each(n,function(t,n){return p[t]&&e.each(p[t],function(e,r){return o+="	"+r+t+": "+n+";\n"}),o+="	"+t+": "+n+";\n"}),o+="}\n"}),i.css&&(o+="/* styles for "+i.name+" */\n"+i.css),o&&(i.cssElem=m(o),i.cssElem.attr("id","notify-"+i.name));var u={},a=e(i.html);g("html",a,u),g("text",a,u),i.fields=u},m=function(t){var n,r,i;r=S("style"),r.attr("type","text/css"),e("head").append(r);try{r.html(t)}catch(s){r[0].styleSheet.cssText=t}return r},g=function(t,n,r){var s;return t!=="html"&&(t="text"),s="data-notify-"+t,y(n,"["+s+"]").each(function(){var n;n=e(this).attr(s),n||(n=i),r[n]=t})},y=function(e,t){return e.is(t)?e:e.find(t)},b={clickToHide:!0,autoHide:!0,autoHideDelay:5e3,arrowShow:!0,arrowSize:5,breakNewLines:!0,elementPosition:"bottom",globalPosition:"top right",style:"bootstrap",className:"error",showAnimation:"slideDown",showDuration:400,hideAnimation:"slideUp",hideDuration:200,gap:5},w=function(t,n){var r;return r=function(){},r.prototype=t,e.extend(!0,new r,n)},E=function(t){return e.extend(b,t)},S=function(t){return e("<"+t+"></"+t+">")},x={},T=function(t){var n;return t.is("[type=radio]")&&(n=t.parents("form:first").find("[type=radio]").filter(function(n,r){return e(r).attr("name")===t.attr("name")}),t=n.first()),t},N=function(e,t,n){var r,i;if(typeof n=="string")n=parseInt(n,10);else if(typeof n!="number")return;if(isNaN(n))return;return r=s[f[t.charAt(0)]],i=t,e[r]!==undefined&&(t=s[r.charAt(0)],n=-n),e[t]===undefined?e[t]=n:e[t]+=n,null},C=function(e,t,n){if(e==="l"||e==="t")return 0;if(e==="c"||e==="m")return n/2-t/2;if(e==="r"||e==="b")return n-t;throw"Invalid alignment"},k=function(e){return k.e=k.e||S("div"),k.e.text(e).html()};L.prototype.loadHTML=function(){var t;t=this.getStyle(),this.userContainer=e(t.html),this.userFields=t.fields},L.prototype.show=function(e,t){var n,r,i,s,o;r=function(n){return function(){!e&&!n.elem&&n.destroy();if(t)return t()}}(this),o=this.container.parent().parents(":hidden").length>0,i=this.container.add(this.arrow),n=[];if(o&&e)s="show";else if(o&&!e)s="hide";else if(!o&&e)s=this.options.showAnimation,n.push(this.options.showDuration);else{if(!!o||!!e)return r();s=this.options.hideAnimation,n.push(this.options.hideDuration)}return n.push(r),i[s].apply(i,n)},L.prototype.setGlobalPosition=function(){var t=this.getPosition(),n=t[0],i=t[1],o=s[n],u=s[i],a=n+"|"+i,f=x[a];if(!f){f=x[a]=S("div");var l={};l[o]=0,u==="middle"?l.top="45%":u==="center"?l.left="45%":l[u]=0,f.css(l).addClass(r+"-corner"),e("body").append(f)}return f.prepend(this.wrapper)},L.prototype.setElementPosition=function(){var n,r,i,l,c,h,p,d,v,m,g,y,b,w,E,S,x,T,k,L,A,O,M,_,D,P,H,B,j;H=this.getPosition(),_=H[0],O=H[1],M=H[2],g=this.elem.position(),d=this.elem.outerHeight(),y=this.elem.outerWidth(),v=this.elem.innerHeight(),m=this.elem.innerWidth(),j=this.wrapper.position(),c=this.container.height(),h=this.container.width(),T=s[_],L=f[_],A=s[L],p={},p[A]=_==="b"?d:_==="r"?y:0,N(p,"top",g.top-j.top),N(p,"left",g.left-j.left),B=["top","left"];for(w=0,S=B.length;w<S;w++)D=B[w],k=parseInt(this.elem.css("margin-"+D),10),k&&N(p,D,k);b=Math.max(0,this.options.gap-(this.options.arrowShow?i:0)),N(p,A,b);if(!this.options.arrowShow)this.arrow.hide();else{i=this.options.arrowSize,r=e.extend({},p),n=this.userContainer.css("border-color")||this.userContainer.css("border-top-color")||this.userContainer.css("background-color")||"white";for(E=0,x=a.length;E<x;E++){D=a[E],P=s[D];if(D===L)continue;l=P===T?n:"transparent",r["border-"+P]=i+"px solid "+l}N(p,s[L],i),t.call(a,O)>=0&&N(r,s[O],i*2)}t.call(u,_)>=0?(N(p,"left",C(O,h,y)),r&&N(r,"left",C(O,i,m))):t.call(o,_)>=0&&(N(p,"top",C(O,c,d)),r&&N(r,"top",C(O,i,v))),this.container.is(":visible")&&(p.display="block"),this.container.removeAttr("style").css(p);if(r)return this.arrow.removeAttr("style").css(r)},L.prototype.getPosition=function(){var e,n,r,i,s,f,c,h;h=this.options.position||(this.elem?this.options.elementPosition:this.options.globalPosition),e=l(h),e.length===0&&(e[0]="b");if(n=e[0],t.call(a,n)<0)throw"Must be one of ["+a+"]";if(e.length===1||(r=e[0],t.call(u,r)>=0)&&(i=e[1],t.call(o,i)<0)||(s=e[0],t.call(o,s)>=0)&&(f=e[1],t.call(u,f)<0))e[1]=(c=e[0],t.call(o,c)>=0)?"m":"l";return e.length===2&&(e[2]=e[1]),e},L.prototype.getStyle=function(e){var t;e||(e=this.options.style),e||(e="default"),t=c[e];if(!t)throw"Missing style: "+e;return t},L.prototype.updateClasses=function(){var t,n;return t=["base"],e.isArray(this.options.className)?t=t.concat(this.options.className):this.options.className&&t.push(this.options.className),n=this.getStyle(),t=e.map(t,function(e){return r+"-"+n.name+"-"+e}).join(" "),this.userContainer.attr("class",t)},L.prototype.run=function(t,n){var r,s,o,u,a;e.isPlainObject(n)?e.extend(this.options,n):e.type(n)==="string"&&(this.options.className=n);if(this.container&&!t){this.show(!1);return}if(!this.container&&!t)return;s={},e.isPlainObject(t)?s=t:s[i]=t;for(o in s){r=s[o],u=this.userFields[o];if(!u)continue;u==="text"&&(r=k(r),this.options.breakNewLines&&(r=r.replace(/\n/g,"<br/>"))),a=o===i?"":"="+o,y(this.userContainer,"[data-notify-"+u+a+"]").html(r)}this.updateClasses(),this.elem?this.setElementPosition():this.setGlobalPosition(),this.show(!0),this.options.autoHide&&(clearTimeout(this.autohideTimer),this.autohideTimer=setTimeout(this.show.bind(this,!1),this.options.autoHideDelay))},L.prototype.destroy=function(){this.wrapper.data(r,null),this.wrapper.remove()},e[n]=function(t,r,i){return t&&t.nodeName||t.jquery?e(t)[n](r,i):(i=r,r=t,new L(null,r,i)),t},e.fn[n]=function(t,n){return e(this).each(function(){var i=T(e(this)).data(r);i&&i.destroy();var s=new L(e(this),t,n)}),this},e.extend(e[n],{defaults:E,addStyle:v,pluginOptions:b,getStyle:d,insertCSS:m}),v("bootstrap",{html:"<div>\n<span data-notify-text></span>\n</div>",classes:{base:{"font-weight":"bold",padding:"8px 15px 8px 14px","text-shadow":"0 1px 0 rgba(255, 255, 255, 0.5)","background-color":"#fcf8e3",border:"1px solid #fbeed5","border-radius":"4px","white-space":"nowrap","padding-left":"25px","background-repeat":"no-repeat","background-position":"3px 7px"},error:{color:"#B94A48","background-color":"#F2DEDE","border-color":"#EED3D7","background-image":"url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAtRJREFUeNqkVc1u00AQHq+dOD+0poIQfkIjalW0SEGqRMuRnHos3DjwAH0ArlyQeANOOSMeAA5VjyBxKBQhgSpVUKKQNGloFdw4cWw2jtfMOna6JOUArDTazXi/b3dm55socPqQhFka++aHBsI8GsopRJERNFlY88FCEk9Yiwf8RhgRyaHFQpPHCDmZG5oX2ui2yilkcTT1AcDsbYC1NMAyOi7zTX2Agx7A9luAl88BauiiQ/cJaZQfIpAlngDcvZZMrl8vFPK5+XktrWlx3/ehZ5r9+t6e+WVnp1pxnNIjgBe4/6dAysQc8dsmHwPcW9C0h3fW1hans1ltwJhy0GxK7XZbUlMp5Ww2eyan6+ft/f2FAqXGK4CvQk5HueFz7D6GOZtIrK+srupdx1GRBBqNBtzc2AiMr7nPplRdKhb1q6q6zjFhrklEFOUutoQ50xcX86ZlqaZpQrfbBdu2R6/G19zX6XSgh6RX5ubyHCM8nqSID6ICrGiZjGYYxojEsiw4PDwMSL5VKsC8Yf4VRYFzMzMaxwjlJSlCyAQ9l0CW44PBADzXhe7xMdi9HtTrdYjFYkDQL0cn4Xdq2/EAE+InCnvADTf2eah4Sx9vExQjkqXT6aAERICMewd/UAp/IeYANM2joxt+q5VI+ieq2i0Wg3l6DNzHwTERPgo1ko7XBXj3vdlsT2F+UuhIhYkp7u7CarkcrFOCtR3H5JiwbAIeImjT/YQKKBtGjRFCU5IUgFRe7fF4cCNVIPMYo3VKqxwjyNAXNepuopyqnld602qVsfRpEkkz+GFL1wPj6ySXBpJtWVa5xlhpcyhBNwpZHmtX8AGgfIExo0ZpzkWVTBGiXCSEaHh62/PoR0p/vHaczxXGnj4bSo+G78lELU80h1uogBwWLf5YlsPmgDEd4M236xjm+8nm4IuE/9u+/PH2JXZfbwz4zw1WbO+SQPpXfwG/BBgAhCNZiSb/pOQAAAAASUVORK5CYII=)"},success:{color:"#468847","background-color":"#DFF0D8","border-color":"#D6E9C6","background-image":"url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAutJREFUeNq0lctPE0Ecx38zu/RFS1EryqtgJFA08YCiMZIAQQ4eRG8eDGdPJiYeTIwHTfwPiAcvXIwXLwoXPaDxkWgQ6islKlJLSQWLUraPLTv7Gme32zoF9KSTfLO7v53vZ3d/M7/fIth+IO6INt2jjoA7bjHCJoAlzCRw59YwHYjBnfMPqAKWQYKjGkfCJqAF0xwZjipQtA3MxeSG87VhOOYegVrUCy7UZM9S6TLIdAamySTclZdYhFhRHloGYg7mgZv1Zzztvgud7V1tbQ2twYA34LJmF4p5dXF1KTufnE+SxeJtuCZNsLDCQU0+RyKTF27Unw101l8e6hns3u0PBalORVVVkcaEKBJDgV3+cGM4tKKmI+ohlIGnygKX00rSBfszz/n2uXv81wd6+rt1orsZCHRdr1Imk2F2Kob3hutSxW8thsd8AXNaln9D7CTfA6O+0UgkMuwVvEFFUbbAcrkcTA8+AtOk8E6KiQiDmMFSDqZItAzEVQviRkdDdaFgPp8HSZKAEAL5Qh7Sq2lIJBJwv2scUqkUnKoZgNhcDKhKg5aH+1IkcouCAdFGAQsuWZYhOjwFHQ96oagWgRoUov1T9kRBEODAwxM2QtEUl+Wp+Ln9VRo6BcMw4ErHRYjH4/B26AlQoQQTRdHWwcd9AH57+UAXddvDD37DmrBBV34WfqiXPl61g+vr6xA9zsGeM9gOdsNXkgpEtTwVvwOklXLKm6+/p5ezwk4B+j6droBs2CsGa/gNs6RIxazl4Tc25mpTgw/apPR1LYlNRFAzgsOxkyXYLIM1V8NMwyAkJSctD1eGVKiq5wWjSPdjmeTkiKvVW4f2YPHWl3GAVq6ymcyCTgovM3FzyRiDe2TaKcEKsLpJvNHjZgPNqEtyi6mZIm4SRFyLMUsONSSdkPeFtY1n0mczoY3BHTLhwPRy9/lzcziCw9ACI+yql0VLzcGAZbYSM5CCSZg1/9oc/nn7+i8N9p/8An4JMADxhH+xHfuiKwAAAABJRU5ErkJggg==)"},info:{color:"#3A87AD","background-color":"#D9EDF7","border-color":"#BCE8F1","background-image":"url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QYFAhkSsdes/QAAA8dJREFUOMvVlGtMW2UYx//POaWHXg6lLaW0ypAtw1UCgbniNOLcVOLmAjHZolOYlxmTGXVZdAnRfXQm+7SoU4mXaOaiZsEpC9FkiQs6Z6bdCnNYruM6KNBw6YWewzl9z+sHImEWv+vz7XmT95f/+3/+7wP814v+efDOV3/SoX3lHAA+6ODeUFfMfjOWMADgdk+eEKz0pF7aQdMAcOKLLjrcVMVX3xdWN29/GhYP7SvnP0cWfS8caSkfHZsPE9Fgnt02JNutQ0QYHB2dDz9/pKX8QjjuO9xUxd/66HdxTeCHZ3rojQObGQBcuNjfplkD3b19Y/6MrimSaKgSMmpGU5WevmE/swa6Oy73tQHA0Rdr2Mmv/6A1n9w9suQ7097Z9lM4FlTgTDrzZTu4StXVfpiI48rVcUDM5cmEksrFnHxfpTtU/3BFQzCQF/2bYVoNbH7zmItbSoMj40JSzmMyX5qDvriA7QdrIIpA+3cdsMpu0nXI8cV0MtKXCPZev+gCEM1S2NHPvWfP/hL+7FSr3+0p5RBEyhEN5JCKYr8XnASMT0xBNyzQGQeI8fjsGD39RMPk7se2bd5ZtTyoFYXftF6y37gx7NeUtJJOTFlAHDZLDuILU3j3+H5oOrD3yWbIztugaAzgnBKJuBLpGfQrS8wO4FZgV+c1IxaLgWVU0tMLEETCos4xMzEIv9cJXQcyagIwigDGwJgOAtHAwAhisQUjy0ORGERiELgG4iakkzo4MYAxcM5hAMi1WWG1yYCJIcMUaBkVRLdGeSU2995TLWzcUAzONJ7J6FBVBYIggMzmFbvdBV44Corg8vjhzC+EJEl8U1kJtgYrhCzgc/vvTwXKSib1paRFVRVORDAJAsw5FuTaJEhWM2SHB3mOAlhkNxwuLzeJsGwqWzf5TFNdKgtY5qHp6ZFf67Y/sAVadCaVY5YACDDb3Oi4NIjLnWMw2QthCBIsVhsUTU9tvXsjeq9+X1d75/KEs4LNOfcdf/+HthMnvwxOD0wmHaXr7ZItn2wuH2SnBzbZAbPJwpPx+VQuzcm7dgRCB57a1uBzUDRL4bfnI0RE0eaXd9W89mpjqHZnUI5Hh2l2dkZZUhOqpi2qSmpOmZ64Tuu9qlz/SEXo6MEHa3wOip46F1n7633eekV8ds8Wxjn37Wl63VVa+ej5oeEZ/82ZBETJjpJ1Rbij2D3Z/1trXUvLsblCK0XfOx0SX2kMsn9dX+d+7Kf6h8o4AIykuffjT8L20LU+w4AZd5VvEPY+XpWqLV327HR7DzXuDnD8r+ovkBehJ8i+y8YAAAAASUVORK5CYII=)"},warn:{color:"#C09853","background-color":"#FCF8E3","border-color":"#FBEED5","background-image":"url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAMAAAC6V+0/AAABJlBMVEXr6eb/2oD/wi7/xjr/0mP/ykf/tQD/vBj/3o7/uQ//vyL/twebhgD/4pzX1K3z8e349vK6tHCilCWbiQymn0jGworr6dXQza3HxcKkn1vWvV/5uRfk4dXZ1bD18+/52YebiAmyr5S9mhCzrWq5t6ufjRH54aLs0oS+qD751XqPhAybhwXsujG3sm+Zk0PTwG6Shg+PhhObhwOPgQL4zV2nlyrf27uLfgCPhRHu7OmLgAafkyiWkD3l49ibiAfTs0C+lgCniwD4sgDJxqOilzDWowWFfAH08uebig6qpFHBvH/aw26FfQTQzsvy8OyEfz20r3jAvaKbhgG9q0nc2LbZxXanoUu/u5WSggCtp1anpJKdmFz/zlX/1nGJiYmuq5Dx7+sAAADoPUZSAAAAAXRSTlMAQObYZgAAAAFiS0dEAIgFHUgAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfdBgUBGhh4aah5AAAAlklEQVQY02NgoBIIE8EUcwn1FkIXM1Tj5dDUQhPU502Mi7XXQxGz5uVIjGOJUUUW81HnYEyMi2HVcUOICQZzMMYmxrEyMylJwgUt5BljWRLjmJm4pI1hYp5SQLGYxDgmLnZOVxuooClIDKgXKMbN5ggV1ACLJcaBxNgcoiGCBiZwdWxOETBDrTyEFey0jYJ4eHjMGWgEAIpRFRCUt08qAAAAAElFTkSuQmCC)"}}}),e(function(){m(h.css).attr("id","core-notify"),e(document).on("click","."+r+"-hidable",function(t){e(this).trigger("notify-hide")}),e(document).on("notify-hide","."+r+"-wrapper",function(t){var n=e(this).data(r);n&&n.show(!1)})})})

;
/*! jQuery UI - v1.12.0 - 2016-07-14
 * http://jqueryui.com
 * Includes: widget.js, position.js, data.js, disable-selection.js, focusable.js, form-reset-mixin.js, keycode.js, labels.js, scroll-parent.js, tabbable.js, unique-id.js, widgets/draggable.js, widgets/resizable.js, widgets/button.js, widgets/checkboxradio.js, widgets/controlgroup.js, widgets/dialog.js, widgets/mouse.js, widgets/slider.js, widgets/tabs.js
 * Copyright jQuery Foundation and other contributors; Licensed MIT */

(function(t){"function"==typeof define&&define.amd?define(["jquery"],t):t(jQuery)})(function(t){function e(t){for(var e=t.css("visibility");"inherit"===e;)t=t.parent(),e=t.css("visibility");return"hidden"!==e}t.ui=t.ui||{},t.ui.version="1.12.0";var i=0,s=Array.prototype.slice;t.cleanData=function(e){return function(i){var s,n,o;for(o=0;null!=(n=i[o]);o++)try{s=t._data(n,"events"),s&&s.remove&&t(n).triggerHandler("remove")}catch(a){}e(i)}}(t.cleanData),t.widget=function(e,i,s){var n,o,a,r={},h=e.split(".")[0];e=e.split(".")[1];var l=h+"-"+e;return s||(s=i,i=t.Widget),t.isArray(s)&&(s=t.extend.apply(null,[{}].concat(s))),t.expr[":"][l.toLowerCase()]=function(e){return!!t.data(e,l)},t[h]=t[h]||{},n=t[h][e],o=t[h][e]=function(t,e){return this._createWidget?(arguments.length&&this._createWidget(t,e),void 0):new o(t,e)},t.extend(o,n,{version:s.version,_proto:t.extend({},s),_childConstructors:[]}),a=new i,a.options=t.widget.extend({},a.options),t.each(s,function(e,s){return t.isFunction(s)?(r[e]=function(){function t(){return i.prototype[e].apply(this,arguments)}function n(t){return i.prototype[e].apply(this,t)}return function(){var e,i=this._super,o=this._superApply;return this._super=t,this._superApply=n,e=s.apply(this,arguments),this._super=i,this._superApply=o,e}}(),void 0):(r[e]=s,void 0)}),o.prototype=t.widget.extend(a,{widgetEventPrefix:n?a.widgetEventPrefix||e:e},r,{constructor:o,namespace:h,widgetName:e,widgetFullName:l}),n?(t.each(n._childConstructors,function(e,i){var s=i.prototype;t.widget(s.namespace+"."+s.widgetName,o,i._proto)}),delete n._childConstructors):i._childConstructors.push(o),t.widget.bridge(e,o),o},t.widget.extend=function(e){for(var i,n,o=s.call(arguments,1),a=0,r=o.length;r>a;a++)for(i in o[a])n=o[a][i],o[a].hasOwnProperty(i)&&void 0!==n&&(e[i]=t.isPlainObject(n)?t.isPlainObject(e[i])?t.widget.extend({},e[i],n):t.widget.extend({},n):n);return e},t.widget.bridge=function(e,i){var n=i.prototype.widgetFullName||e;t.fn[e]=function(o){var a="string"==typeof o,r=s.call(arguments,1),h=this;return a?this.each(function(){var i,s=t.data(this,n);return"instance"===o?(h=s,!1):s?t.isFunction(s[o])&&"_"!==o.charAt(0)?(i=s[o].apply(s,r),i!==s&&void 0!==i?(h=i&&i.jquery?h.pushStack(i.get()):i,!1):void 0):t.error("no such method '"+o+"' for "+e+" widget instance"):t.error("cannot call methods on "+e+" prior to initialization; "+"attempted to call method '"+o+"'")}):(r.length&&(o=t.widget.extend.apply(null,[o].concat(r))),this.each(function(){var e=t.data(this,n);e?(e.option(o||{}),e._init&&e._init()):t.data(this,n,new i(o,this))})),h}},t.Widget=function(){},t.Widget._childConstructors=[],t.Widget.prototype={widgetName:"widget",widgetEventPrefix:"",defaultElement:"<div>",options:{classes:{},disabled:!1,create:null},_createWidget:function(e,s){s=t(s||this.defaultElement||this)[0],this.element=t(s),this.uuid=i++,this.eventNamespace="."+this.widgetName+this.uuid,this.bindings=t(),this.hoverable=t(),this.focusable=t(),this.classesElementLookup={},s!==this&&(t.data(s,this.widgetFullName,this),this._on(!0,this.element,{remove:function(t){t.target===s&&this.destroy()}}),this.document=t(s.style?s.ownerDocument:s.document||s),this.window=t(this.document[0].defaultView||this.document[0].parentWindow)),this.options=t.widget.extend({},this.options,this._getCreateOptions(),e),this._create(),this.options.disabled&&this._setOptionDisabled(this.options.disabled),this._trigger("create",null,this._getCreateEventData()),this._init()},_getCreateOptions:function(){return{}},_getCreateEventData:t.noop,_create:t.noop,_init:t.noop,destroy:function(){var e=this;this._destroy(),t.each(this.classesElementLookup,function(t,i){e._removeClass(i,t)}),this.element.off(this.eventNamespace).removeData(this.widgetFullName),this.widget().off(this.eventNamespace).removeAttr("aria-disabled"),this.bindings.off(this.eventNamespace)},_destroy:t.noop,widget:function(){return this.element},option:function(e,i){var s,n,o,a=e;if(0===arguments.length)return t.widget.extend({},this.options);if("string"==typeof e)if(a={},s=e.split("."),e=s.shift(),s.length){for(n=a[e]=t.widget.extend({},this.options[e]),o=0;s.length-1>o;o++)n[s[o]]=n[s[o]]||{},n=n[s[o]];if(e=s.pop(),1===arguments.length)return void 0===n[e]?null:n[e];n[e]=i}else{if(1===arguments.length)return void 0===this.options[e]?null:this.options[e];a[e]=i}return this._setOptions(a),this},_setOptions:function(t){var e;for(e in t)this._setOption(e,t[e]);return this},_setOption:function(t,e){return"classes"===t&&this._setOptionClasses(e),this.options[t]=e,"disabled"===t&&this._setOptionDisabled(e),this},_setOptionClasses:function(e){var i,s,n;for(i in e)n=this.classesElementLookup[i],e[i]!==this.options.classes[i]&&n&&n.length&&(s=t(n.get()),this._removeClass(n,i),s.addClass(this._classes({element:s,keys:i,classes:e,add:!0})))},_setOptionDisabled:function(t){this._toggleClass(this.widget(),this.widgetFullName+"-disabled",null,!!t),t&&(this._removeClass(this.hoverable,null,"ui-state-hover"),this._removeClass(this.focusable,null,"ui-state-focus"))},enable:function(){return this._setOptions({disabled:!1})},disable:function(){return this._setOptions({disabled:!0})},_classes:function(e){function i(i,o){var a,r;for(r=0;i.length>r;r++)a=n.classesElementLookup[i[r]]||t(),a=e.add?t(t.unique(a.get().concat(e.element.get()))):t(a.not(e.element).get()),n.classesElementLookup[i[r]]=a,s.push(i[r]),o&&e.classes[i[r]]&&s.push(e.classes[i[r]])}var s=[],n=this;return e=t.extend({element:this.element,classes:this.options.classes||{}},e),e.keys&&i(e.keys.match(/\S+/g)||[],!0),e.extra&&i(e.extra.match(/\S+/g)||[]),s.join(" ")},_removeClass:function(t,e,i){return this._toggleClass(t,e,i,!1)},_addClass:function(t,e,i){return this._toggleClass(t,e,i,!0)},_toggleClass:function(t,e,i,s){s="boolean"==typeof s?s:i;var n="string"==typeof t||null===t,o={extra:n?e:i,keys:n?t:e,element:n?this.element:t,add:s};return o.element.toggleClass(this._classes(o),s),this},_on:function(e,i,s){var n,o=this;"boolean"!=typeof e&&(s=i,i=e,e=!1),s?(i=n=t(i),this.bindings=this.bindings.add(i)):(s=i,i=this.element,n=this.widget()),t.each(s,function(s,a){function r(){return e||o.options.disabled!==!0&&!t(this).hasClass("ui-state-disabled")?("string"==typeof a?o[a]:a).apply(o,arguments):void 0}"string"!=typeof a&&(r.guid=a.guid=a.guid||r.guid||t.guid++);var h=s.match(/^([\w:-]*)\s*(.*)$/),l=h[1]+o.eventNamespace,c=h[2];c?n.on(l,c,r):i.on(l,r)})},_off:function(e,i){i=(i||"").split(" ").join(this.eventNamespace+" ")+this.eventNamespace,e.off(i).off(i),this.bindings=t(this.bindings.not(e).get()),this.focusable=t(this.focusable.not(e).get()),this.hoverable=t(this.hoverable.not(e).get())},_delay:function(t,e){function i(){return("string"==typeof t?s[t]:t).apply(s,arguments)}var s=this;return setTimeout(i,e||0)},_hoverable:function(e){this.hoverable=this.hoverable.add(e),this._on(e,{mouseenter:function(e){this._addClass(t(e.currentTarget),null,"ui-state-hover")},mouseleave:function(e){this._removeClass(t(e.currentTarget),null,"ui-state-hover")}})},_focusable:function(e){this.focusable=this.focusable.add(e),this._on(e,{focusin:function(e){this._addClass(t(e.currentTarget),null,"ui-state-focus")},focusout:function(e){this._removeClass(t(e.currentTarget),null,"ui-state-focus")}})},_trigger:function(e,i,s){var n,o,a=this.options[e];if(s=s||{},i=t.Event(i),i.type=(e===this.widgetEventPrefix?e:this.widgetEventPrefix+e).toLowerCase(),i.target=this.element[0],o=i.originalEvent)for(n in o)n in i||(i[n]=o[n]);return this.element.trigger(i,s),!(t.isFunction(a)&&a.apply(this.element[0],[i].concat(s))===!1||i.isDefaultPrevented())}},t.each({show:"fadeIn",hide:"fadeOut"},function(e,i){t.Widget.prototype["_"+e]=function(s,n,o){"string"==typeof n&&(n={effect:n});var a,r=n?n===!0||"number"==typeof n?i:n.effect||i:e;n=n||{},"number"==typeof n&&(n={duration:n}),a=!t.isEmptyObject(n),n.complete=o,n.delay&&s.delay(n.delay),a&&t.effects&&t.effects.effect[r]?s[e](n):r!==e&&s[r]?s[r](n.duration,n.easing,o):s.queue(function(i){t(this)[e](),o&&o.call(s[0]),i()})}}),t.widget,function(){function e(t,e,i){return[parseFloat(t[0])*(p.test(t[0])?e/100:1),parseFloat(t[1])*(p.test(t[1])?i/100:1)]}function i(e,i){return parseInt(t.css(e,i),10)||0}function s(e){var i=e[0];return 9===i.nodeType?{width:e.width(),height:e.height(),offset:{top:0,left:0}}:t.isWindow(i)?{width:e.width(),height:e.height(),offset:{top:e.scrollTop(),left:e.scrollLeft()}}:i.preventDefault?{width:0,height:0,offset:{top:i.pageY,left:i.pageX}}:{width:e.outerWidth(),height:e.outerHeight(),offset:e.offset()}}var n,o,a=Math.max,r=Math.abs,h=Math.round,l=/left|center|right/,c=/top|center|bottom/,u=/[\+\-]\d+(\.[\d]+)?%?/,d=/^\w+/,p=/%$/,f=t.fn.position;o=function(){var e=t("<div>").css("position","absolute").appendTo("body").offset({top:1.5,left:1.5}),i=1.5===e.offset().top;return e.remove(),o=function(){return i},i},t.position={scrollbarWidth:function(){if(void 0!==n)return n;var e,i,s=t("<div style='display:block;position:absolute;width:50px;height:50px;overflow:hidden;'><div style='height:100px;width:auto;'></div></div>"),o=s.children()[0];return t("body").append(s),e=o.offsetWidth,s.css("overflow","scroll"),i=o.offsetWidth,e===i&&(i=s[0].clientWidth),s.remove(),n=e-i},getScrollInfo:function(e){var i=e.isWindow||e.isDocument?"":e.element.css("overflow-x"),s=e.isWindow||e.isDocument?"":e.element.css("overflow-y"),n="scroll"===i||"auto"===i&&e.width<e.element[0].scrollWidth,o="scroll"===s||"auto"===s&&e.height<e.element[0].scrollHeight;return{width:o?t.position.scrollbarWidth():0,height:n?t.position.scrollbarWidth():0}},getWithinInfo:function(e){var i=t(e||window),s=t.isWindow(i[0]),n=!!i[0]&&9===i[0].nodeType,o=!s&&!n;return{element:i,isWindow:s,isDocument:n,offset:o?t(e).offset():{left:0,top:0},scrollLeft:i.scrollLeft(),scrollTop:i.scrollTop(),width:i.outerWidth(),height:i.outerHeight()}}},t.fn.position=function(n){if(!n||!n.of)return f.apply(this,arguments);n=t.extend({},n);var p,g,m,_,v,b,y=t(n.of),w=t.position.getWithinInfo(n.within),k=t.position.getScrollInfo(w),x=(n.collision||"flip").split(" "),C={};return b=s(y),y[0].preventDefault&&(n.at="left top"),g=b.width,m=b.height,_=b.offset,v=t.extend({},_),t.each(["my","at"],function(){var t,e,i=(n[this]||"").split(" ");1===i.length&&(i=l.test(i[0])?i.concat(["center"]):c.test(i[0])?["center"].concat(i):["center","center"]),i[0]=l.test(i[0])?i[0]:"center",i[1]=c.test(i[1])?i[1]:"center",t=u.exec(i[0]),e=u.exec(i[1]),C[this]=[t?t[0]:0,e?e[0]:0],n[this]=[d.exec(i[0])[0],d.exec(i[1])[0]]}),1===x.length&&(x[1]=x[0]),"right"===n.at[0]?v.left+=g:"center"===n.at[0]&&(v.left+=g/2),"bottom"===n.at[1]?v.top+=m:"center"===n.at[1]&&(v.top+=m/2),p=e(C.at,g,m),v.left+=p[0],v.top+=p[1],this.each(function(){var s,l,c=t(this),u=c.outerWidth(),d=c.outerHeight(),f=i(this,"marginLeft"),b=i(this,"marginTop"),D=u+f+i(this,"marginRight")+k.width,I=d+b+i(this,"marginBottom")+k.height,T=t.extend({},v),P=e(C.my,c.outerWidth(),c.outerHeight());"right"===n.my[0]?T.left-=u:"center"===n.my[0]&&(T.left-=u/2),"bottom"===n.my[1]?T.top-=d:"center"===n.my[1]&&(T.top-=d/2),T.left+=P[0],T.top+=P[1],o()||(T.left=h(T.left),T.top=h(T.top)),s={marginLeft:f,marginTop:b},t.each(["left","top"],function(e,i){t.ui.position[x[e]]&&t.ui.position[x[e]][i](T,{targetWidth:g,targetHeight:m,elemWidth:u,elemHeight:d,collisionPosition:s,collisionWidth:D,collisionHeight:I,offset:[p[0]+P[0],p[1]+P[1]],my:n.my,at:n.at,within:w,elem:c})}),n.using&&(l=function(t){var e=_.left-T.left,i=e+g-u,s=_.top-T.top,o=s+m-d,h={target:{element:y,left:_.left,top:_.top,width:g,height:m},element:{element:c,left:T.left,top:T.top,width:u,height:d},horizontal:0>i?"left":e>0?"right":"center",vertical:0>o?"top":s>0?"bottom":"middle"};u>g&&g>r(e+i)&&(h.horizontal="center"),d>m&&m>r(s+o)&&(h.vertical="middle"),h.important=a(r(e),r(i))>a(r(s),r(o))?"horizontal":"vertical",n.using.call(this,t,h)}),c.offset(t.extend(T,{using:l}))})},t.ui.position={fit:{left:function(t,e){var i,s=e.within,n=s.isWindow?s.scrollLeft:s.offset.left,o=s.width,r=t.left-e.collisionPosition.marginLeft,h=n-r,l=r+e.collisionWidth-o-n;e.collisionWidth>o?h>0&&0>=l?(i=t.left+h+e.collisionWidth-o-n,t.left+=h-i):t.left=l>0&&0>=h?n:h>l?n+o-e.collisionWidth:n:h>0?t.left+=h:l>0?t.left-=l:t.left=a(t.left-r,t.left)},top:function(t,e){var i,s=e.within,n=s.isWindow?s.scrollTop:s.offset.top,o=e.within.height,r=t.top-e.collisionPosition.marginTop,h=n-r,l=r+e.collisionHeight-o-n;e.collisionHeight>o?h>0&&0>=l?(i=t.top+h+e.collisionHeight-o-n,t.top+=h-i):t.top=l>0&&0>=h?n:h>l?n+o-e.collisionHeight:n:h>0?t.top+=h:l>0?t.top-=l:t.top=a(t.top-r,t.top)}},flip:{left:function(t,e){var i,s,n=e.within,o=n.offset.left+n.scrollLeft,a=n.width,h=n.isWindow?n.scrollLeft:n.offset.left,l=t.left-e.collisionPosition.marginLeft,c=l-h,u=l+e.collisionWidth-a-h,d="left"===e.my[0]?-e.elemWidth:"right"===e.my[0]?e.elemWidth:0,p="left"===e.at[0]?e.targetWidth:"right"===e.at[0]?-e.targetWidth:0,f=-2*e.offset[0];0>c?(i=t.left+d+p+f+e.collisionWidth-a-o,(0>i||r(c)>i)&&(t.left+=d+p+f)):u>0&&(s=t.left-e.collisionPosition.marginLeft+d+p+f-h,(s>0||u>r(s))&&(t.left+=d+p+f))},top:function(t,e){var i,s,n=e.within,o=n.offset.top+n.scrollTop,a=n.height,h=n.isWindow?n.scrollTop:n.offset.top,l=t.top-e.collisionPosition.marginTop,c=l-h,u=l+e.collisionHeight-a-h,d="top"===e.my[1],p=d?-e.elemHeight:"bottom"===e.my[1]?e.elemHeight:0,f="top"===e.at[1]?e.targetHeight:"bottom"===e.at[1]?-e.targetHeight:0,g=-2*e.offset[1];0>c?(s=t.top+p+f+g+e.collisionHeight-a-o,(0>s||r(c)>s)&&(t.top+=p+f+g)):u>0&&(i=t.top-e.collisionPosition.marginTop+p+f+g-h,(i>0||u>r(i))&&(t.top+=p+f+g))}},flipfit:{left:function(){t.ui.position.flip.left.apply(this,arguments),t.ui.position.fit.left.apply(this,arguments)},top:function(){t.ui.position.flip.top.apply(this,arguments),t.ui.position.fit.top.apply(this,arguments)}}}}(),t.ui.position,t.extend(t.expr[":"],{data:t.expr.createPseudo?t.expr.createPseudo(function(e){return function(i){return!!t.data(i,e)}}):function(e,i,s){return!!t.data(e,s[3])}}),t.fn.extend({disableSelection:function(){var t="onselectstart"in document.createElement("div")?"selectstart":"mousedown";return function(){return this.on(t+".ui-disableSelection",function(t){t.preventDefault()})}}(),enableSelection:function(){return this.off(".ui-disableSelection")}}),t.ui.focusable=function(i,s){var n,o,a,r,h,l=i.nodeName.toLowerCase();return"area"===l?(n=i.parentNode,o=n.name,i.href&&o&&"map"===n.nodeName.toLowerCase()?(a=t("img[usemap='#"+o+"']"),a.length>0&&a.is(":visible")):!1):(/^(input|select|textarea|button|object)$/.test(l)?(r=!i.disabled,r&&(h=t(i).closest("fieldset")[0],h&&(r=!h.disabled))):r="a"===l?i.href||s:s,r&&t(i).is(":visible")&&e(t(i)))},t.extend(t.expr[":"],{focusable:function(e){return t.ui.focusable(e,null!=t.attr(e,"tabindex"))}}),t.ui.focusable,t.fn.form=function(){return"string"==typeof this[0].form?this.closest("form"):t(this[0].form)},t.ui.formResetMixin={_formResetHandler:function(){var e=t(this);setTimeout(function(){var i=e.data("ui-form-reset-instances");t.each(i,function(){this.refresh()})})},_bindFormResetHandler:function(){if(this.form=this.element.form(),this.form.length){var t=this.form.data("ui-form-reset-instances")||[];t.length||this.form.on("reset.ui-form-reset",this._formResetHandler),t.push(this),this.form.data("ui-form-reset-instances",t)}},_unbindFormResetHandler:function(){if(this.form.length){var e=this.form.data("ui-form-reset-instances");e.splice(t.inArray(this,e),1),e.length?this.form.data("ui-form-reset-instances",e):this.form.removeData("ui-form-reset-instances").off("reset.ui-form-reset")}}},t.ui.keyCode={BACKSPACE:8,COMMA:188,DELETE:46,DOWN:40,END:35,ENTER:13,ESCAPE:27,HOME:36,LEFT:37,PAGE_DOWN:34,PAGE_UP:33,PERIOD:190,RIGHT:39,SPACE:32,TAB:9,UP:38},t.ui.escapeSelector=function(){var t=/([!"#$%&'()*+,./:;<=>?@[\]^`{|}~])/g;return function(e){return e.replace(t,"\\$1")}}(),t.fn.labels=function(){var e,i,s,n,o;return this[0].labels&&this[0].labels.length?this.pushStack(this[0].labels):(n=this.eq(0).parents("label"),s=this.attr("id"),s&&(e=this.eq(0).parents().last(),o=e.add(e.length?e.siblings():this.siblings()),i="label[for='"+t.ui.escapeSelector(s)+"']",n=n.add(o.find(i).addBack(i))),this.pushStack(n))},t.fn.scrollParent=function(e){var i=this.css("position"),s="absolute"===i,n=e?/(auto|scroll|hidden)/:/(auto|scroll)/,o=this.parents().filter(function(){var e=t(this);return s&&"static"===e.css("position")?!1:n.test(e.css("overflow")+e.css("overflow-y")+e.css("overflow-x"))}).eq(0);return"fixed"!==i&&o.length?o:t(this[0].ownerDocument||document)},t.extend(t.expr[":"],{tabbable:function(e){var i=t.attr(e,"tabindex"),s=null!=i;return(!s||i>=0)&&t.ui.focusable(e,s)}}),t.fn.extend({uniqueId:function(){var t=0;return function(){return this.each(function(){this.id||(this.id="ui-id-"+ ++t)})}}(),removeUniqueId:function(){return this.each(function(){/^ui-id-\d+$/.test(this.id)&&t(this).removeAttr("id")})}}),t.ui.ie=!!/msie [\w.]+/.exec(navigator.userAgent.toLowerCase());var n=!1;t(document).on("mouseup",function(){n=!1}),t.widget("ui.mouse",{version:"1.12.0",options:{cancel:"input, textarea, button, select, option",distance:1,delay:0},_mouseInit:function(){var e=this;this.element.on("mousedown."+this.widgetName,function(t){return e._mouseDown(t)}).on("click."+this.widgetName,function(i){return!0===t.data(i.target,e.widgetName+".preventClickEvent")?(t.removeData(i.target,e.widgetName+".preventClickEvent"),i.stopImmediatePropagation(),!1):void 0}),this.started=!1},_mouseDestroy:function(){this.element.off("."+this.widgetName),this._mouseMoveDelegate&&this.document.off("mousemove."+this.widgetName,this._mouseMoveDelegate).off("mouseup."+this.widgetName,this._mouseUpDelegate)},_mouseDown:function(e){if(!n){this._mouseMoved=!1,this._mouseStarted&&this._mouseUp(e),this._mouseDownEvent=e;var i=this,s=1===e.which,o="string"==typeof this.options.cancel&&e.target.nodeName?t(e.target).closest(this.options.cancel).length:!1;return s&&!o&&this._mouseCapture(e)?(this.mouseDelayMet=!this.options.delay,this.mouseDelayMet||(this._mouseDelayTimer=setTimeout(function(){i.mouseDelayMet=!0},this.options.delay)),this._mouseDistanceMet(e)&&this._mouseDelayMet(e)&&(this._mouseStarted=this._mouseStart(e)!==!1,!this._mouseStarted)?(e.preventDefault(),!0):(!0===t.data(e.target,this.widgetName+".preventClickEvent")&&t.removeData(e.target,this.widgetName+".preventClickEvent"),this._mouseMoveDelegate=function(t){return i._mouseMove(t)},this._mouseUpDelegate=function(t){return i._mouseUp(t)},this.document.on("mousemove."+this.widgetName,this._mouseMoveDelegate).on("mouseup."+this.widgetName,this._mouseUpDelegate),e.preventDefault(),n=!0,!0)):!0}},_mouseMove:function(e){if(this._mouseMoved){if(t.ui.ie&&(!document.documentMode||9>document.documentMode)&&!e.button)return this._mouseUp(e);if(!e.which)if(e.originalEvent.altKey||e.originalEvent.ctrlKey||e.originalEvent.metaKey||e.originalEvent.shiftKey)this.ignoreMissingWhich=!0;else if(!this.ignoreMissingWhich)return this._mouseUp(e)}return(e.which||e.button)&&(this._mouseMoved=!0),this._mouseStarted?(this._mouseDrag(e),e.preventDefault()):(this._mouseDistanceMet(e)&&this._mouseDelayMet(e)&&(this._mouseStarted=this._mouseStart(this._mouseDownEvent,e)!==!1,this._mouseStarted?this._mouseDrag(e):this._mouseUp(e)),!this._mouseStarted)},_mouseUp:function(e){this.document.off("mousemove."+this.widgetName,this._mouseMoveDelegate).off("mouseup."+this.widgetName,this._mouseUpDelegate),this._mouseStarted&&(this._mouseStarted=!1,e.target===this._mouseDownEvent.target&&t.data(e.target,this.widgetName+".preventClickEvent",!0),this._mouseStop(e)),this._mouseDelayTimer&&(clearTimeout(this._mouseDelayTimer),delete this._mouseDelayTimer),this.ignoreMissingWhich=!1,n=!1,e.preventDefault()},_mouseDistanceMet:function(t){return Math.max(Math.abs(this._mouseDownEvent.pageX-t.pageX),Math.abs(this._mouseDownEvent.pageY-t.pageY))>=this.options.distance},_mouseDelayMet:function(){return this.mouseDelayMet},_mouseStart:function(){},_mouseDrag:function(){},_mouseStop:function(){},_mouseCapture:function(){return!0}}),t.ui.plugin={add:function(e,i,s){var n,o=t.ui[e].prototype;for(n in s)o.plugins[n]=o.plugins[n]||[],o.plugins[n].push([i,s[n]])},call:function(t,e,i,s){var n,o=t.plugins[e];if(o&&(s||t.element[0].parentNode&&11!==t.element[0].parentNode.nodeType))for(n=0;o.length>n;n++)t.options[o[n][0]]&&o[n][1].apply(t.element,i)}},t.ui.safeActiveElement=function(t){var e;try{e=t.activeElement}catch(i){e=t.body}return e||(e=t.body),e.nodeName||(e=t.body),e},t.ui.safeBlur=function(e){e&&"body"!==e.nodeName.toLowerCase()&&t(e).trigger("blur")},t.widget("ui.draggable",t.ui.mouse,{version:"1.12.0",widgetEventPrefix:"drag",options:{addClasses:!0,appendTo:"parent",axis:!1,connectToSortable:!1,containment:!1,cursor:"auto",cursorAt:!1,grid:!1,handle:!1,helper:"original",iframeFix:!1,opacity:!1,refreshPositions:!1,revert:!1,revertDuration:500,scope:"default",scroll:!0,scrollSensitivity:20,scrollSpeed:20,snap:!1,snapMode:"both",snapTolerance:20,stack:!1,zIndex:!1,drag:null,start:null,stop:null},_create:function(){"original"===this.options.helper&&this._setPositionRelative(),this.options.addClasses&&this._addClass("ui-draggable"),this._setHandleClassName(),this._mouseInit()},_setOption:function(t,e){this._super(t,e),"handle"===t&&(this._removeHandleClassName(),this._setHandleClassName())},_destroy:function(){return(this.helper||this.element).is(".ui-draggable-dragging")?(this.destroyOnClear=!0,void 0):(this._removeHandleClassName(),this._mouseDestroy(),void 0)},_mouseCapture:function(e){var i=this.options;return this._blurActiveElement(e),this.helper||i.disabled||t(e.target).closest(".ui-resizable-handle").length>0?!1:(this.handle=this._getHandle(e),this.handle?(this._blockFrames(i.iframeFix===!0?"iframe":i.iframeFix),!0):!1)},_blockFrames:function(e){this.iframeBlocks=this.document.find(e).map(function(){var e=t(this);return t("<div>").css("position","absolute").appendTo(e.parent()).outerWidth(e.outerWidth()).outerHeight(e.outerHeight()).offset(e.offset())[0]})},_unblockFrames:function(){this.iframeBlocks&&(this.iframeBlocks.remove(),delete this.iframeBlocks)},_blurActiveElement:function(e){var i=t.ui.safeActiveElement(this.document[0]),s=t(e.target);this._getHandle(e)&&s.closest(i).length||t.ui.safeBlur(i)},_mouseStart:function(e){var i=this.options;return this.helper=this._createHelper(e),this._addClass(this.helper,"ui-draggable-dragging"),this._cacheHelperProportions(),t.ui.ddmanager&&(t.ui.ddmanager.current=this),this._cacheMargins(),this.cssPosition=this.helper.css("position"),this.scrollParent=this.helper.scrollParent(!0),this.offsetParent=this.helper.offsetParent(),this.hasFixedAncestor=this.helper.parents().filter(function(){return"fixed"===t(this).css("position")}).length>0,this.positionAbs=this.element.offset(),this._refreshOffsets(e),this.originalPosition=this.position=this._generatePosition(e,!1),this.originalPageX=e.pageX,this.originalPageY=e.pageY,i.cursorAt&&this._adjustOffsetFromHelper(i.cursorAt),this._setContainment(),this._trigger("start",e)===!1?(this._clear(),!1):(this._cacheHelperProportions(),t.ui.ddmanager&&!i.dropBehaviour&&t.ui.ddmanager.prepareOffsets(this,e),this._mouseDrag(e,!0),t.ui.ddmanager&&t.ui.ddmanager.dragStart(this,e),!0)},_refreshOffsets:function(t){this.offset={top:this.positionAbs.top-this.margins.top,left:this.positionAbs.left-this.margins.left,scroll:!1,parent:this._getParentOffset(),relative:this._getRelativeOffset()},this.offset.click={left:t.pageX-this.offset.left,top:t.pageY-this.offset.top}},_mouseDrag:function(e,i){if(this.hasFixedAncestor&&(this.offset.parent=this._getParentOffset()),this.position=this._generatePosition(e,!0),this.positionAbs=this._convertPositionTo("absolute"),!i){var s=this._uiHash();if(this._trigger("drag",e,s)===!1)return this._mouseUp(new t.Event("mouseup",e)),!1;this.position=s.position}return this.helper[0].style.left=this.position.left+"px",this.helper[0].style.top=this.position.top+"px",t.ui.ddmanager&&t.ui.ddmanager.drag(this,e),!1},_mouseStop:function(e){var i=this,s=!1;return t.ui.ddmanager&&!this.options.dropBehaviour&&(s=t.ui.ddmanager.drop(this,e)),this.dropped&&(s=this.dropped,this.dropped=!1),"invalid"===this.options.revert&&!s||"valid"===this.options.revert&&s||this.options.revert===!0||t.isFunction(this.options.revert)&&this.options.revert.call(this.element,s)?t(this.helper).animate(this.originalPosition,parseInt(this.options.revertDuration,10),function(){i._trigger("stop",e)!==!1&&i._clear()}):this._trigger("stop",e)!==!1&&this._clear(),!1},_mouseUp:function(e){return this._unblockFrames(),t.ui.ddmanager&&t.ui.ddmanager.dragStop(this,e),this.handleElement.is(e.target)&&this.element.trigger("focus"),t.ui.mouse.prototype._mouseUp.call(this,e)},cancel:function(){return this.helper.is(".ui-draggable-dragging")?this._mouseUp(new t.Event("mouseup",{target:this.element[0]})):this._clear(),this},_getHandle:function(e){return this.options.handle?!!t(e.target).closest(this.element.find(this.options.handle)).length:!0},_setHandleClassName:function(){this.handleElement=this.options.handle?this.element.find(this.options.handle):this.element,this._addClass(this.handleElement,"ui-draggable-handle")},_removeHandleClassName:function(){this._removeClass(this.handleElement,"ui-draggable-handle")},_createHelper:function(e){var i=this.options,s=t.isFunction(i.helper),n=s?t(i.helper.apply(this.element[0],[e])):"clone"===i.helper?this.element.clone().removeAttr("id"):this.element;return n.parents("body").length||n.appendTo("parent"===i.appendTo?this.element[0].parentNode:i.appendTo),s&&n[0]===this.element[0]&&this._setPositionRelative(),n[0]===this.element[0]||/(fixed|absolute)/.test(n.css("position"))||n.css("position","absolute"),n},_setPositionRelative:function(){/^(?:r|a|f)/.test(this.element.css("position"))||(this.element[0].style.position="relative")},_adjustOffsetFromHelper:function(e){"string"==typeof e&&(e=e.split(" ")),t.isArray(e)&&(e={left:+e[0],top:+e[1]||0}),"left"in e&&(this.offset.click.left=e.left+this.margins.left),"right"in e&&(this.offset.click.left=this.helperProportions.width-e.right+this.margins.left),"top"in e&&(this.offset.click.top=e.top+this.margins.top),"bottom"in e&&(this.offset.click.top=this.helperProportions.height-e.bottom+this.margins.top)},_isRootNode:function(t){return/(html|body)/i.test(t.tagName)||t===this.document[0]},_getParentOffset:function(){var e=this.offsetParent.offset(),i=this.document[0];return"absolute"===this.cssPosition&&this.scrollParent[0]!==i&&t.contains(this.scrollParent[0],this.offsetParent[0])&&(e.left+=this.scrollParent.scrollLeft(),e.top+=this.scrollParent.scrollTop()),this._isRootNode(this.offsetParent[0])&&(e={top:0,left:0}),{top:e.top+(parseInt(this.offsetParent.css("borderTopWidth"),10)||0),left:e.left+(parseInt(this.offsetParent.css("borderLeftWidth"),10)||0)}},_getRelativeOffset:function(){if("relative"!==this.cssPosition)return{top:0,left:0};var t=this.element.position(),e=this._isRootNode(this.scrollParent[0]);return{top:t.top-(parseInt(this.helper.css("top"),10)||0)+(e?0:this.scrollParent.scrollTop()),left:t.left-(parseInt(this.helper.css("left"),10)||0)+(e?0:this.scrollParent.scrollLeft())}},_cacheMargins:function(){this.margins={left:parseInt(this.element.css("marginLeft"),10)||0,top:parseInt(this.element.css("marginTop"),10)||0,right:parseInt(this.element.css("marginRight"),10)||0,bottom:parseInt(this.element.css("marginBottom"),10)||0}},_cacheHelperProportions:function(){this.helperProportions={width:this.helper.outerWidth(),height:this.helper.outerHeight()}},_setContainment:function(){var e,i,s,n=this.options,o=this.document[0];return this.relativeContainer=null,n.containment?"window"===n.containment?(this.containment=[t(window).scrollLeft()-this.offset.relative.left-this.offset.parent.left,t(window).scrollTop()-this.offset.relative.top-this.offset.parent.top,t(window).scrollLeft()+t(window).width()-this.helperProportions.width-this.margins.left,t(window).scrollTop()+(t(window).height()||o.body.parentNode.scrollHeight)-this.helperProportions.height-this.margins.top],void 0):"document"===n.containment?(this.containment=[0,0,t(o).width()-this.helperProportions.width-this.margins.left,(t(o).height()||o.body.parentNode.scrollHeight)-this.helperProportions.height-this.margins.top],void 0):n.containment.constructor===Array?(this.containment=n.containment,void 0):("parent"===n.containment&&(n.containment=this.helper[0].parentNode),i=t(n.containment),s=i[0],s&&(e=/(scroll|auto)/.test(i.css("overflow")),this.containment=[(parseInt(i.css("borderLeftWidth"),10)||0)+(parseInt(i.css("paddingLeft"),10)||0),(parseInt(i.css("borderTopWidth"),10)||0)+(parseInt(i.css("paddingTop"),10)||0),(e?Math.max(s.scrollWidth,s.offsetWidth):s.offsetWidth)-(parseInt(i.css("borderRightWidth"),10)||0)-(parseInt(i.css("paddingRight"),10)||0)-this.helperProportions.width-this.margins.left-this.margins.right,(e?Math.max(s.scrollHeight,s.offsetHeight):s.offsetHeight)-(parseInt(i.css("borderBottomWidth"),10)||0)-(parseInt(i.css("paddingBottom"),10)||0)-this.helperProportions.height-this.margins.top-this.margins.bottom],this.relativeContainer=i),void 0):(this.containment=null,void 0)},_convertPositionTo:function(t,e){e||(e=this.position);var i="absolute"===t?1:-1,s=this._isRootNode(this.scrollParent[0]);return{top:e.top+this.offset.relative.top*i+this.offset.parent.top*i-("fixed"===this.cssPosition?-this.offset.scroll.top:s?0:this.offset.scroll.top)*i,left:e.left+this.offset.relative.left*i+this.offset.parent.left*i-("fixed"===this.cssPosition?-this.offset.scroll.left:s?0:this.offset.scroll.left)*i}},_generatePosition:function(t,e){var i,s,n,o,a=this.options,r=this._isRootNode(this.scrollParent[0]),h=t.pageX,l=t.pageY;return r&&this.offset.scroll||(this.offset.scroll={top:this.scrollParent.scrollTop(),left:this.scrollParent.scrollLeft()}),e&&(this.containment&&(this.relativeContainer?(s=this.relativeContainer.offset(),i=[this.containment[0]+s.left,this.containment[1]+s.top,this.containment[2]+s.left,this.containment[3]+s.top]):i=this.containment,t.pageX-this.offset.click.left<i[0]&&(h=i[0]+this.offset.click.left),t.pageY-this.offset.click.top<i[1]&&(l=i[1]+this.offset.click.top),t.pageX-this.offset.click.left>i[2]&&(h=i[2]+this.offset.click.left),t.pageY-this.offset.click.top>i[3]&&(l=i[3]+this.offset.click.top)),a.grid&&(n=a.grid[1]?this.originalPageY+Math.round((l-this.originalPageY)/a.grid[1])*a.grid[1]:this.originalPageY,l=i?n-this.offset.click.top>=i[1]||n-this.offset.click.top>i[3]?n:n-this.offset.click.top>=i[1]?n-a.grid[1]:n+a.grid[1]:n,o=a.grid[0]?this.originalPageX+Math.round((h-this.originalPageX)/a.grid[0])*a.grid[0]:this.originalPageX,h=i?o-this.offset.click.left>=i[0]||o-this.offset.click.left>i[2]?o:o-this.offset.click.left>=i[0]?o-a.grid[0]:o+a.grid[0]:o),"y"===a.axis&&(h=this.originalPageX),"x"===a.axis&&(l=this.originalPageY)),{top:l-this.offset.click.top-this.offset.relative.top-this.offset.parent.top+("fixed"===this.cssPosition?-this.offset.scroll.top:r?0:this.offset.scroll.top),left:h-this.offset.click.left-this.offset.relative.left-this.offset.parent.left+("fixed"===this.cssPosition?-this.offset.scroll.left:r?0:this.offset.scroll.left)}},_clear:function(){this._removeClass(this.helper,"ui-draggable-dragging"),this.helper[0]===this.element[0]||this.cancelHelperRemoval||this.helper.remove(),this.helper=null,this.cancelHelperRemoval=!1,this.destroyOnClear&&this.destroy()},_trigger:function(e,i,s){return s=s||this._uiHash(),t.ui.plugin.call(this,e,[i,s,this],!0),/^(drag|start|stop)/.test(e)&&(this.positionAbs=this._convertPositionTo("absolute"),s.offset=this.positionAbs),t.Widget.prototype._trigger.call(this,e,i,s)},plugins:{},_uiHash:function(){return{helper:this.helper,position:this.position,originalPosition:this.originalPosition,offset:this.positionAbs}}}),t.ui.plugin.add("draggable","connectToSortable",{start:function(e,i,s){var n=t.extend({},i,{item:s.element});s.sortables=[],t(s.options.connectToSortable).each(function(){var i=t(this).sortable("instance");
    i&&!i.options.disabled&&(s.sortables.push(i),i.refreshPositions(),i._trigger("activate",e,n))})},stop:function(e,i,s){var n=t.extend({},i,{item:s.element});s.cancelHelperRemoval=!1,t.each(s.sortables,function(){var t=this;t.isOver?(t.isOver=0,s.cancelHelperRemoval=!0,t.cancelHelperRemoval=!1,t._storedCSS={position:t.placeholder.css("position"),top:t.placeholder.css("top"),left:t.placeholder.css("left")},t._mouseStop(e),t.options.helper=t.options._helper):(t.cancelHelperRemoval=!0,t._trigger("deactivate",e,n))})},drag:function(e,i,s){t.each(s.sortables,function(){var n=!1,o=this;o.positionAbs=s.positionAbs,o.helperProportions=s.helperProportions,o.offset.click=s.offset.click,o._intersectsWith(o.containerCache)&&(n=!0,t.each(s.sortables,function(){return this.positionAbs=s.positionAbs,this.helperProportions=s.helperProportions,this.offset.click=s.offset.click,this!==o&&this._intersectsWith(this.containerCache)&&t.contains(o.element[0],this.element[0])&&(n=!1),n})),n?(o.isOver||(o.isOver=1,s._parent=i.helper.parent(),o.currentItem=i.helper.appendTo(o.element).data("ui-sortable-item",!0),o.options._helper=o.options.helper,o.options.helper=function(){return i.helper[0]},e.target=o.currentItem[0],o._mouseCapture(e,!0),o._mouseStart(e,!0,!0),o.offset.click.top=s.offset.click.top,o.offset.click.left=s.offset.click.left,o.offset.parent.left-=s.offset.parent.left-o.offset.parent.left,o.offset.parent.top-=s.offset.parent.top-o.offset.parent.top,s._trigger("toSortable",e),s.dropped=o.element,t.each(s.sortables,function(){this.refreshPositions()}),s.currentItem=s.element,o.fromOutside=s),o.currentItem&&(o._mouseDrag(e),i.position=o.position)):o.isOver&&(o.isOver=0,o.cancelHelperRemoval=!0,o.options._revert=o.options.revert,o.options.revert=!1,o._trigger("out",e,o._uiHash(o)),o._mouseStop(e,!0),o.options.revert=o.options._revert,o.options.helper=o.options._helper,o.placeholder&&o.placeholder.remove(),i.helper.appendTo(s._parent),s._refreshOffsets(e),i.position=s._generatePosition(e,!0),s._trigger("fromSortable",e),s.dropped=!1,t.each(s.sortables,function(){this.refreshPositions()}))})}}),t.ui.plugin.add("draggable","cursor",{start:function(e,i,s){var n=t("body"),o=s.options;n.css("cursor")&&(o._cursor=n.css("cursor")),n.css("cursor",o.cursor)},stop:function(e,i,s){var n=s.options;n._cursor&&t("body").css("cursor",n._cursor)}}),t.ui.plugin.add("draggable","opacity",{start:function(e,i,s){var n=t(i.helper),o=s.options;n.css("opacity")&&(o._opacity=n.css("opacity")),n.css("opacity",o.opacity)},stop:function(e,i,s){var n=s.options;n._opacity&&t(i.helper).css("opacity",n._opacity)}}),t.ui.plugin.add("draggable","scroll",{start:function(t,e,i){i.scrollParentNotHidden||(i.scrollParentNotHidden=i.helper.scrollParent(!1)),i.scrollParentNotHidden[0]!==i.document[0]&&"HTML"!==i.scrollParentNotHidden[0].tagName&&(i.overflowOffset=i.scrollParentNotHidden.offset())},drag:function(e,i,s){var n=s.options,o=!1,a=s.scrollParentNotHidden[0],r=s.document[0];a!==r&&"HTML"!==a.tagName?(n.axis&&"x"===n.axis||(s.overflowOffset.top+a.offsetHeight-e.pageY<n.scrollSensitivity?a.scrollTop=o=a.scrollTop+n.scrollSpeed:e.pageY-s.overflowOffset.top<n.scrollSensitivity&&(a.scrollTop=o=a.scrollTop-n.scrollSpeed)),n.axis&&"y"===n.axis||(s.overflowOffset.left+a.offsetWidth-e.pageX<n.scrollSensitivity?a.scrollLeft=o=a.scrollLeft+n.scrollSpeed:e.pageX-s.overflowOffset.left<n.scrollSensitivity&&(a.scrollLeft=o=a.scrollLeft-n.scrollSpeed))):(n.axis&&"x"===n.axis||(e.pageY-t(r).scrollTop()<n.scrollSensitivity?o=t(r).scrollTop(t(r).scrollTop()-n.scrollSpeed):t(window).height()-(e.pageY-t(r).scrollTop())<n.scrollSensitivity&&(o=t(r).scrollTop(t(r).scrollTop()+n.scrollSpeed))),n.axis&&"y"===n.axis||(e.pageX-t(r).scrollLeft()<n.scrollSensitivity?o=t(r).scrollLeft(t(r).scrollLeft()-n.scrollSpeed):t(window).width()-(e.pageX-t(r).scrollLeft())<n.scrollSensitivity&&(o=t(r).scrollLeft(t(r).scrollLeft()+n.scrollSpeed)))),o!==!1&&t.ui.ddmanager&&!n.dropBehaviour&&t.ui.ddmanager.prepareOffsets(s,e)}}),t.ui.plugin.add("draggable","snap",{start:function(e,i,s){var n=s.options;s.snapElements=[],t(n.snap.constructor!==String?n.snap.items||":data(ui-draggable)":n.snap).each(function(){var e=t(this),i=e.offset();this!==s.element[0]&&s.snapElements.push({item:this,width:e.outerWidth(),height:e.outerHeight(),top:i.top,left:i.left})})},drag:function(e,i,s){var n,o,a,r,h,l,c,u,d,p,f=s.options,g=f.snapTolerance,m=i.offset.left,_=m+s.helperProportions.width,v=i.offset.top,b=v+s.helperProportions.height;for(d=s.snapElements.length-1;d>=0;d--)h=s.snapElements[d].left-s.margins.left,l=h+s.snapElements[d].width,c=s.snapElements[d].top-s.margins.top,u=c+s.snapElements[d].height,h-g>_||m>l+g||c-g>b||v>u+g||!t.contains(s.snapElements[d].item.ownerDocument,s.snapElements[d].item)?(s.snapElements[d].snapping&&s.options.snap.release&&s.options.snap.release.call(s.element,e,t.extend(s._uiHash(),{snapItem:s.snapElements[d].item})),s.snapElements[d].snapping=!1):("inner"!==f.snapMode&&(n=g>=Math.abs(c-b),o=g>=Math.abs(u-v),a=g>=Math.abs(h-_),r=g>=Math.abs(l-m),n&&(i.position.top=s._convertPositionTo("relative",{top:c-s.helperProportions.height,left:0}).top),o&&(i.position.top=s._convertPositionTo("relative",{top:u,left:0}).top),a&&(i.position.left=s._convertPositionTo("relative",{top:0,left:h-s.helperProportions.width}).left),r&&(i.position.left=s._convertPositionTo("relative",{top:0,left:l}).left)),p=n||o||a||r,"outer"!==f.snapMode&&(n=g>=Math.abs(c-v),o=g>=Math.abs(u-b),a=g>=Math.abs(h-m),r=g>=Math.abs(l-_),n&&(i.position.top=s._convertPositionTo("relative",{top:c,left:0}).top),o&&(i.position.top=s._convertPositionTo("relative",{top:u-s.helperProportions.height,left:0}).top),a&&(i.position.left=s._convertPositionTo("relative",{top:0,left:h}).left),r&&(i.position.left=s._convertPositionTo("relative",{top:0,left:l-s.helperProportions.width}).left)),!s.snapElements[d].snapping&&(n||o||a||r||p)&&s.options.snap.snap&&s.options.snap.snap.call(s.element,e,t.extend(s._uiHash(),{snapItem:s.snapElements[d].item})),s.snapElements[d].snapping=n||o||a||r||p)}}),t.ui.plugin.add("draggable","stack",{start:function(e,i,s){var n,o=s.options,a=t.makeArray(t(o.stack)).sort(function(e,i){return(parseInt(t(e).css("zIndex"),10)||0)-(parseInt(t(i).css("zIndex"),10)||0)});a.length&&(n=parseInt(t(a[0]).css("zIndex"),10)||0,t(a).each(function(e){t(this).css("zIndex",n+e)}),this.css("zIndex",n+a.length))}}),t.ui.plugin.add("draggable","zIndex",{start:function(e,i,s){var n=t(i.helper),o=s.options;n.css("zIndex")&&(o._zIndex=n.css("zIndex")),n.css("zIndex",o.zIndex)},stop:function(e,i,s){var n=s.options;n._zIndex&&t(i.helper).css("zIndex",n._zIndex)}}),t.ui.draggable,t.widget("ui.resizable",t.ui.mouse,{version:"1.12.0",widgetEventPrefix:"resize",options:{alsoResize:!1,animate:!1,animateDuration:"slow",animateEasing:"swing",aspectRatio:!1,autoHide:!1,classes:{"ui-resizable-se":"ui-icon ui-icon-gripsmall-diagonal-se"},containment:!1,ghost:!1,grid:!1,handles:"e,s,se",helper:!1,maxHeight:null,maxWidth:null,minHeight:10,minWidth:10,zIndex:90,resize:null,start:null,stop:null},_num:function(t){return parseFloat(t)||0},_isNumber:function(t){return!isNaN(parseFloat(t))},_hasScroll:function(e,i){if("hidden"===t(e).css("overflow"))return!1;var s=i&&"left"===i?"scrollLeft":"scrollTop",n=!1;return e[s]>0?!0:(e[s]=1,n=e[s]>0,e[s]=0,n)},_create:function(){var e,i=this.options,s=this;this._addClass("ui-resizable"),t.extend(this,{_aspectRatio:!!i.aspectRatio,aspectRatio:i.aspectRatio,originalElement:this.element,_proportionallyResizeElements:[],_helper:i.helper||i.ghost||i.animate?i.helper||"ui-resizable-helper":null}),this.element[0].nodeName.match(/^(canvas|textarea|input|select|button|img)$/i)&&(this.element.wrap(t("<div class='ui-wrapper' style='overflow: hidden;'></div>").css({position:this.element.css("position"),width:this.element.outerWidth(),height:this.element.outerHeight(),top:this.element.css("top"),left:this.element.css("left")})),this.element=this.element.parent().data("ui-resizable",this.element.resizable("instance")),this.elementIsWrapper=!0,e={marginTop:this.originalElement.css("marginTop"),marginRight:this.originalElement.css("marginRight"),marginBottom:this.originalElement.css("marginBottom"),marginLeft:this.originalElement.css("marginLeft")},this.element.css(e),this.originalElement.css("margin",0),this.originalResizeStyle=this.originalElement.css("resize"),this.originalElement.css("resize","none"),this._proportionallyResizeElements.push(this.originalElement.css({position:"static",zoom:1,display:"block"})),this.originalElement.css(e),this._proportionallyResize()),this._setupHandles(),i.autoHide&&t(this.element).on("mouseenter",function(){i.disabled||(s._removeClass("ui-resizable-autohide"),s._handles.show())}).on("mouseleave",function(){i.disabled||s.resizing||(s._addClass("ui-resizable-autohide"),s._handles.hide())}),this._mouseInit()},_destroy:function(){this._mouseDestroy();var e,i=function(e){t(e).removeData("resizable").removeData("ui-resizable").off(".resizable").find(".ui-resizable-handle").remove()};return this.elementIsWrapper&&(i(this.element),e=this.element,this.originalElement.css({position:e.css("position"),width:e.outerWidth(),height:e.outerHeight(),top:e.css("top"),left:e.css("left")}).insertAfter(e),e.remove()),this.originalElement.css("resize",this.originalResizeStyle),i(this.originalElement),this},_setOption:function(t,e){switch(this._super(t,e),t){case"handles":this._removeHandles(),this._setupHandles();break;default:}},_setupHandles:function(){var e,i,s,n,o,a=this.options,r=this;if(this.handles=a.handles||(t(".ui-resizable-handle",this.element).length?{n:".ui-resizable-n",e:".ui-resizable-e",s:".ui-resizable-s",w:".ui-resizable-w",se:".ui-resizable-se",sw:".ui-resizable-sw",ne:".ui-resizable-ne",nw:".ui-resizable-nw"}:"e,s,se"),this._handles=t(),this.handles.constructor===String)for("all"===this.handles&&(this.handles="n,e,s,w,se,sw,ne,nw"),s=this.handles.split(","),this.handles={},i=0;s.length>i;i++)e=t.trim(s[i]),n="ui-resizable-"+e,o=t("<div>"),this._addClass(o,"ui-resizable-handle "+n),o.css({zIndex:a.zIndex}),this.handles[e]=".ui-resizable-"+e,this.element.append(o);this._renderAxis=function(e){var i,s,n,o;e=e||this.element;for(i in this.handles)this.handles[i].constructor===String?this.handles[i]=this.element.children(this.handles[i]).first().show():(this.handles[i].jquery||this.handles[i].nodeType)&&(this.handles[i]=t(this.handles[i]),this._on(this.handles[i],{mousedown:r._mouseDown})),this.elementIsWrapper&&this.originalElement[0].nodeName.match(/^(textarea|input|select|button)$/i)&&(s=t(this.handles[i],this.element),o=/sw|ne|nw|se|n|s/.test(i)?s.outerHeight():s.outerWidth(),n=["padding",/ne|nw|n/.test(i)?"Top":/se|sw|s/.test(i)?"Bottom":/^e$/.test(i)?"Right":"Left"].join(""),e.css(n,o),this._proportionallyResize()),this._handles=this._handles.add(this.handles[i])},this._renderAxis(this.element),this._handles=this._handles.add(this.element.find(".ui-resizable-handle")),this._handles.disableSelection(),this._handles.on("mouseover",function(){r.resizing||(this.className&&(o=this.className.match(/ui-resizable-(se|sw|ne|nw|n|e|s|w)/i)),r.axis=o&&o[1]?o[1]:"se")}),a.autoHide&&(this._handles.hide(),this._addClass("ui-resizable-autohide"))},_removeHandles:function(){this._handles.remove()},_mouseCapture:function(e){var i,s,n=!1;for(i in this.handles)s=t(this.handles[i])[0],(s===e.target||t.contains(s,e.target))&&(n=!0);return!this.options.disabled&&n},_mouseStart:function(e){var i,s,n,o=this.options,a=this.element;return this.resizing=!0,this._renderProxy(),i=this._num(this.helper.css("left")),s=this._num(this.helper.css("top")),o.containment&&(i+=t(o.containment).scrollLeft()||0,s+=t(o.containment).scrollTop()||0),this.offset=this.helper.offset(),this.position={left:i,top:s},this.size=this._helper?{width:this.helper.width(),height:this.helper.height()}:{width:a.width(),height:a.height()},this.originalSize=this._helper?{width:a.outerWidth(),height:a.outerHeight()}:{width:a.width(),height:a.height()},this.sizeDiff={width:a.outerWidth()-a.width(),height:a.outerHeight()-a.height()},this.originalPosition={left:i,top:s},this.originalMousePosition={left:e.pageX,top:e.pageY},this.aspectRatio="number"==typeof o.aspectRatio?o.aspectRatio:this.originalSize.width/this.originalSize.height||1,n=t(".ui-resizable-"+this.axis).css("cursor"),t("body").css("cursor","auto"===n?this.axis+"-resize":n),this._addClass("ui-resizable-resizing"),this._propagate("start",e),!0},_mouseDrag:function(e){var i,s,n=this.originalMousePosition,o=this.axis,a=e.pageX-n.left||0,r=e.pageY-n.top||0,h=this._change[o];return this._updatePrevProperties(),h?(i=h.apply(this,[e,a,r]),this._updateVirtualBoundaries(e.shiftKey),(this._aspectRatio||e.shiftKey)&&(i=this._updateRatio(i,e)),i=this._respectSize(i,e),this._updateCache(i),this._propagate("resize",e),s=this._applyChanges(),!this._helper&&this._proportionallyResizeElements.length&&this._proportionallyResize(),t.isEmptyObject(s)||(this._updatePrevProperties(),this._trigger("resize",e,this.ui()),this._applyChanges()),!1):!1},_mouseStop:function(e){this.resizing=!1;var i,s,n,o,a,r,h,l=this.options,c=this;return this._helper&&(i=this._proportionallyResizeElements,s=i.length&&/textarea/i.test(i[0].nodeName),n=s&&this._hasScroll(i[0],"left")?0:c.sizeDiff.height,o=s?0:c.sizeDiff.width,a={width:c.helper.width()-o,height:c.helper.height()-n},r=parseFloat(c.element.css("left"))+(c.position.left-c.originalPosition.left)||null,h=parseFloat(c.element.css("top"))+(c.position.top-c.originalPosition.top)||null,l.animate||this.element.css(t.extend(a,{top:h,left:r})),c.helper.height(c.size.height),c.helper.width(c.size.width),this._helper&&!l.animate&&this._proportionallyResize()),t("body").css("cursor","auto"),this._removeClass("ui-resizable-resizing"),this._propagate("stop",e),this._helper&&this.helper.remove(),!1},_updatePrevProperties:function(){this.prevPosition={top:this.position.top,left:this.position.left},this.prevSize={width:this.size.width,height:this.size.height}},_applyChanges:function(){var t={};return this.position.top!==this.prevPosition.top&&(t.top=this.position.top+"px"),this.position.left!==this.prevPosition.left&&(t.left=this.position.left+"px"),this.size.width!==this.prevSize.width&&(t.width=this.size.width+"px"),this.size.height!==this.prevSize.height&&(t.height=this.size.height+"px"),this.helper.css(t),t},_updateVirtualBoundaries:function(t){var e,i,s,n,o,a=this.options;o={minWidth:this._isNumber(a.minWidth)?a.minWidth:0,maxWidth:this._isNumber(a.maxWidth)?a.maxWidth:1/0,minHeight:this._isNumber(a.minHeight)?a.minHeight:0,maxHeight:this._isNumber(a.maxHeight)?a.maxHeight:1/0},(this._aspectRatio||t)&&(e=o.minHeight*this.aspectRatio,s=o.minWidth/this.aspectRatio,i=o.maxHeight*this.aspectRatio,n=o.maxWidth/this.aspectRatio,e>o.minWidth&&(o.minWidth=e),s>o.minHeight&&(o.minHeight=s),o.maxWidth>i&&(o.maxWidth=i),o.maxHeight>n&&(o.maxHeight=n)),this._vBoundaries=o},_updateCache:function(t){this.offset=this.helper.offset(),this._isNumber(t.left)&&(this.position.left=t.left),this._isNumber(t.top)&&(this.position.top=t.top),this._isNumber(t.height)&&(this.size.height=t.height),this._isNumber(t.width)&&(this.size.width=t.width)},_updateRatio:function(t){var e=this.position,i=this.size,s=this.axis;return this._isNumber(t.height)?t.width=t.height*this.aspectRatio:this._isNumber(t.width)&&(t.height=t.width/this.aspectRatio),"sw"===s&&(t.left=e.left+(i.width-t.width),t.top=null),"nw"===s&&(t.top=e.top+(i.height-t.height),t.left=e.left+(i.width-t.width)),t},_respectSize:function(t){var e=this._vBoundaries,i=this.axis,s=this._isNumber(t.width)&&e.maxWidth&&e.maxWidth<t.width,n=this._isNumber(t.height)&&e.maxHeight&&e.maxHeight<t.height,o=this._isNumber(t.width)&&e.minWidth&&e.minWidth>t.width,a=this._isNumber(t.height)&&e.minHeight&&e.minHeight>t.height,r=this.originalPosition.left+this.originalSize.width,h=this.originalPosition.top+this.originalSize.height,l=/sw|nw|w/.test(i),c=/nw|ne|n/.test(i);return o&&(t.width=e.minWidth),a&&(t.height=e.minHeight),s&&(t.width=e.maxWidth),n&&(t.height=e.maxHeight),o&&l&&(t.left=r-e.minWidth),s&&l&&(t.left=r-e.maxWidth),a&&c&&(t.top=h-e.minHeight),n&&c&&(t.top=h-e.maxHeight),t.width||t.height||t.left||!t.top?t.width||t.height||t.top||!t.left||(t.left=null):t.top=null,t},_getPaddingPlusBorderDimensions:function(t){for(var e=0,i=[],s=[t.css("borderTopWidth"),t.css("borderRightWidth"),t.css("borderBottomWidth"),t.css("borderLeftWidth")],n=[t.css("paddingTop"),t.css("paddingRight"),t.css("paddingBottom"),t.css("paddingLeft")];4>e;e++)i[e]=parseFloat(s[e])||0,i[e]+=parseFloat(n[e])||0;return{height:i[0]+i[2],width:i[1]+i[3]}},_proportionallyResize:function(){if(this._proportionallyResizeElements.length)for(var t,e=0,i=this.helper||this.element;this._proportionallyResizeElements.length>e;e++)t=this._proportionallyResizeElements[e],this.outerDimensions||(this.outerDimensions=this._getPaddingPlusBorderDimensions(t)),t.css({height:i.height()-this.outerDimensions.height||0,width:i.width()-this.outerDimensions.width||0})},_renderProxy:function(){var e=this.element,i=this.options;this.elementOffset=e.offset(),this._helper?(this.helper=this.helper||t("<div style='overflow:hidden;'></div>"),this._addClass(this.helper,this._helper),this.helper.css({width:this.element.outerWidth(),height:this.element.outerHeight(),position:"absolute",left:this.elementOffset.left+"px",top:this.elementOffset.top+"px",zIndex:++i.zIndex}),this.helper.appendTo("body").disableSelection()):this.helper=this.element},_change:{e:function(t,e){return{width:this.originalSize.width+e}},w:function(t,e){var i=this.originalSize,s=this.originalPosition;return{left:s.left+e,width:i.width-e}},n:function(t,e,i){var s=this.originalSize,n=this.originalPosition;return{top:n.top+i,height:s.height-i}},s:function(t,e,i){return{height:this.originalSize.height+i}},se:function(e,i,s){return t.extend(this._change.s.apply(this,arguments),this._change.e.apply(this,[e,i,s]))},sw:function(e,i,s){return t.extend(this._change.s.apply(this,arguments),this._change.w.apply(this,[e,i,s]))},ne:function(e,i,s){return t.extend(this._change.n.apply(this,arguments),this._change.e.apply(this,[e,i,s]))},nw:function(e,i,s){return t.extend(this._change.n.apply(this,arguments),this._change.w.apply(this,[e,i,s]))}},_propagate:function(e,i){t.ui.plugin.call(this,e,[i,this.ui()]),"resize"!==e&&this._trigger(e,i,this.ui())},plugins:{},ui:function(){return{originalElement:this.originalElement,element:this.element,helper:this.helper,position:this.position,size:this.size,originalSize:this.originalSize,originalPosition:this.originalPosition}}}),t.ui.plugin.add("resizable","animate",{stop:function(e){var i=t(this).resizable("instance"),s=i.options,n=i._proportionallyResizeElements,o=n.length&&/textarea/i.test(n[0].nodeName),a=o&&i._hasScroll(n[0],"left")?0:i.sizeDiff.height,r=o?0:i.sizeDiff.width,h={width:i.size.width-r,height:i.size.height-a},l=parseFloat(i.element.css("left"))+(i.position.left-i.originalPosition.left)||null,c=parseFloat(i.element.css("top"))+(i.position.top-i.originalPosition.top)||null;i.element.animate(t.extend(h,c&&l?{top:c,left:l}:{}),{duration:s.animateDuration,easing:s.animateEasing,step:function(){var s={width:parseFloat(i.element.css("width")),height:parseFloat(i.element.css("height")),top:parseFloat(i.element.css("top")),left:parseFloat(i.element.css("left"))};n&&n.length&&t(n[0]).css({width:s.width,height:s.height}),i._updateCache(s),i._propagate("resize",e)}})}}),t.ui.plugin.add("resizable","containment",{start:function(){var e,i,s,n,o,a,r,h=t(this).resizable("instance"),l=h.options,c=h.element,u=l.containment,d=u instanceof t?u.get(0):/parent/.test(u)?c.parent().get(0):u;d&&(h.containerElement=t(d),/document/.test(u)||u===document?(h.containerOffset={left:0,top:0},h.containerPosition={left:0,top:0},h.parentData={element:t(document),left:0,top:0,width:t(document).width(),height:t(document).height()||document.body.parentNode.scrollHeight}):(e=t(d),i=[],t(["Top","Right","Left","Bottom"]).each(function(t,s){i[t]=h._num(e.css("padding"+s))}),h.containerOffset=e.offset(),h.containerPosition=e.position(),h.containerSize={height:e.innerHeight()-i[3],width:e.innerWidth()-i[1]},s=h.containerOffset,n=h.containerSize.height,o=h.containerSize.width,a=h._hasScroll(d,"left")?d.scrollWidth:o,r=h._hasScroll(d)?d.scrollHeight:n,h.parentData={element:d,left:s.left,top:s.top,width:a,height:r}))},resize:function(e){var i,s,n,o,a=t(this).resizable("instance"),r=a.options,h=a.containerOffset,l=a.position,c=a._aspectRatio||e.shiftKey,u={top:0,left:0},d=a.containerElement,p=!0;d[0]!==document&&/static/.test(d.css("position"))&&(u=h),l.left<(a._helper?h.left:0)&&(a.size.width=a.size.width+(a._helper?a.position.left-h.left:a.position.left-u.left),c&&(a.size.height=a.size.width/a.aspectRatio,p=!1),a.position.left=r.helper?h.left:0),l.top<(a._helper?h.top:0)&&(a.size.height=a.size.height+(a._helper?a.position.top-h.top:a.position.top),c&&(a.size.width=a.size.height*a.aspectRatio,p=!1),a.position.top=a._helper?h.top:0),n=a.containerElement.get(0)===a.element.parent().get(0),o=/relative|absolute/.test(a.containerElement.css("position")),n&&o?(a.offset.left=a.parentData.left+a.position.left,a.offset.top=a.parentData.top+a.position.top):(a.offset.left=a.element.offset().left,a.offset.top=a.element.offset().top),i=Math.abs(a.sizeDiff.width+(a._helper?a.offset.left-u.left:a.offset.left-h.left)),s=Math.abs(a.sizeDiff.height+(a._helper?a.offset.top-u.top:a.offset.top-h.top)),i+a.size.width>=a.parentData.width&&(a.size.width=a.parentData.width-i,c&&(a.size.height=a.size.width/a.aspectRatio,p=!1)),s+a.size.height>=a.parentData.height&&(a.size.height=a.parentData.height-s,c&&(a.size.width=a.size.height*a.aspectRatio,p=!1)),p||(a.position.left=a.prevPosition.left,a.position.top=a.prevPosition.top,a.size.width=a.prevSize.width,a.size.height=a.prevSize.height)},stop:function(){var e=t(this).resizable("instance"),i=e.options,s=e.containerOffset,n=e.containerPosition,o=e.containerElement,a=t(e.helper),r=a.offset(),h=a.outerWidth()-e.sizeDiff.width,l=a.outerHeight()-e.sizeDiff.height;e._helper&&!i.animate&&/relative/.test(o.css("position"))&&t(this).css({left:r.left-n.left-s.left,width:h,height:l}),e._helper&&!i.animate&&/static/.test(o.css("position"))&&t(this).css({left:r.left-n.left-s.left,width:h,height:l})}}),t.ui.plugin.add("resizable","alsoResize",{start:function(){var e=t(this).resizable("instance"),i=e.options;t(i.alsoResize).each(function(){var e=t(this);e.data("ui-resizable-alsoresize",{width:parseFloat(e.width()),height:parseFloat(e.height()),left:parseFloat(e.css("left")),top:parseFloat(e.css("top"))})})},resize:function(e,i){var s=t(this).resizable("instance"),n=s.options,o=s.originalSize,a=s.originalPosition,r={height:s.size.height-o.height||0,width:s.size.width-o.width||0,top:s.position.top-a.top||0,left:s.position.left-a.left||0};t(n.alsoResize).each(function(){var e=t(this),s=t(this).data("ui-resizable-alsoresize"),n={},o=e.parents(i.originalElement[0]).length?["width","height"]:["width","height","top","left"];t.each(o,function(t,e){var i=(s[e]||0)+(r[e]||0);i&&i>=0&&(n[e]=i||null)}),e.css(n)})},stop:function(){t(this).removeData("ui-resizable-alsoresize")}}),t.ui.plugin.add("resizable","ghost",{start:function(){var e=t(this).resizable("instance"),i=e.size;e.ghost=e.originalElement.clone(),e.ghost.css({opacity:.25,display:"block",position:"relative",height:i.height,width:i.width,margin:0,left:0,top:0}),e._addClass(e.ghost,"ui-resizable-ghost"),t.uiBackCompat!==!1&&"string"==typeof e.options.ghost&&e.ghost.addClass(this.options.ghost),e.ghost.appendTo(e.helper)},resize:function(){var e=t(this).resizable("instance");e.ghost&&e.ghost.css({position:"relative",height:e.size.height,width:e.size.width})},stop:function(){var e=t(this).resizable("instance");e.ghost&&e.helper&&e.helper.get(0).removeChild(e.ghost.get(0))}}),t.ui.plugin.add("resizable","grid",{resize:function(){var e,i=t(this).resizable("instance"),s=i.options,n=i.size,o=i.originalSize,a=i.originalPosition,r=i.axis,h="number"==typeof s.grid?[s.grid,s.grid]:s.grid,l=h[0]||1,c=h[1]||1,u=Math.round((n.width-o.width)/l)*l,d=Math.round((n.height-o.height)/c)*c,p=o.width+u,f=o.height+d,g=s.maxWidth&&p>s.maxWidth,m=s.maxHeight&&f>s.maxHeight,_=s.minWidth&&s.minWidth>p,v=s.minHeight&&s.minHeight>f;s.grid=h,_&&(p+=l),v&&(f+=c),g&&(p-=l),m&&(f-=c),/^(se|s|e)$/.test(r)?(i.size.width=p,i.size.height=f):/^(ne)$/.test(r)?(i.size.width=p,i.size.height=f,i.position.top=a.top-d):/^(sw)$/.test(r)?(i.size.width=p,i.size.height=f,i.position.left=a.left-u):((0>=f-c||0>=p-l)&&(e=i._getPaddingPlusBorderDimensions(this)),f-c>0?(i.size.height=f,i.position.top=a.top-d):(f=c-e.height,i.size.height=f,i.position.top=a.top+o.height-f),p-l>0?(i.size.width=p,i.position.left=a.left-u):(p=l-e.width,i.size.width=p,i.position.left=a.left+o.width-p))}}),t.ui.resizable;var o=/ui-corner-([a-z]){2,6}/g;t.widget("ui.controlgroup",{version:"1.12.0",defaultElement:"<div>",options:{direction:"horizontal",disabled:null,onlyVisible:!0,items:{button:"input[type=button], input[type=submit], input[type=reset], button, a",controlgroupLabel:".ui-controlgroup-label",checkboxradio:"input[type='checkbox'], input[type='radio']",selectmenu:"select",spinner:".ui-spinner-input"}},_create:function(){this._enhance()},_enhance:function(){this.element.attr("role","toolbar"),this.refresh()},_destroy:function(){this._callChildMethod("destroy"),this.childWidgets.removeData("ui-controlgroup-data"),this.element.removeAttr("role"),this.options.items.controlgroupLabel&&this.element.find(this.options.items.controlgroupLabel).find(".ui-controlgroup-label-contents").contents().unwrap()},_initWidgets:function(){var e=this,i=[];t.each(this.options.items,function(s,n){var o,a={};return n?"controlgroupLabel"===s?(o=e.element.find(n),o.each(function(){var e=t(this);e.children(".ui-controlgroup-label-contents").length||e.contents().wrapAll("<span class='ui-controlgroup-label-contents'></span>")}),e._addClass(o,null,"ui-widget ui-widget-content ui-state-default"),i=i.concat(o.get()),void 0):(t.fn[s]&&(e["_"+s+"Options"]&&(a=e["_"+s+"Options"]("middle")),e.element.find(n).each(function(){var n=t(this),o=n[s]("instance"),r=t.widget.extend({},a);if("button"!==s||!n.parent(".ui-spinner").length){o||(o=n[s]()[s]("instance")),o&&(r.classes=e._resolveClassesValues(r.classes,o)),n[s](r);var h=n[s]("widget");t.data(h[0],"ui-controlgroup-data",o?o:n[s]("instance")),i.push(h[0])}})),void 0):void 0}),this.childWidgets=t(t.unique(i)),this._addClass(this.childWidgets,"ui-controlgroup-item")},_callChildMethod:function(e){this.childWidgets.each(function(){var i=t(this),s=i.data("ui-controlgroup-data");s&&s[e]&&s[e]()})},_updateCornerClass:function(t,e){var i="ui-corner-top ui-corner-bottom ui-corner-left ui-corner-right ui-corner-all",s=this._buildSimpleOptions(e,"label").classes.label;this._removeClass(t,null,i),this._addClass(t,null,s)},_buildSimpleOptions:function(t,e){var i="vertical"===this.options.direction,s={classes:{}};return s.classes[e]={middle:"",first:"ui-corner-"+(i?"top":"left"),last:"ui-corner-"+(i?"bottom":"right"),only:"ui-corner-all"}[t],s},_spinnerOptions:function(t){var e=this._buildSimpleOptions(t,"ui-spinner");return e.classes["ui-spinner-up"]="",e.classes["ui-spinner-down"]="",e},_buttonOptions:function(t){return this._buildSimpleOptions(t,"ui-button")},_checkboxradioOptions:function(t){return this._buildSimpleOptions(t,"ui-checkboxradio-label")},_selectmenuOptions:function(t){var e="vertical"===this.options.direction;return{width:e?"auto":!1,classes:{middle:{"ui-selectmenu-button-open":"","ui-selectmenu-button-closed":""},first:{"ui-selectmenu-button-open":"ui-corner-"+(e?"top":"tl"),"ui-selectmenu-button-closed":"ui-corner-"+(e?"top":"left")},last:{"ui-selectmenu-button-open":e?"":"ui-corner-tr","ui-selectmenu-button-closed":"ui-corner-"+(e?"bottom":"right")},only:{"ui-selectmenu-button-open":"ui-corner-top","ui-selectmenu-button-closed":"ui-corner-all"}}[t]}},_resolveClassesValues:function(e,i){var s={};return t.each(e,function(t){var n=i.options.classes[t]||"";n=n.replace(o,"").trim(),s[t]=(n+" "+e[t]).replace(/\s+/g," ")}),s},_setOption:function(t,e){return"direction"===t&&this._removeClass("ui-controlgroup-"+this.options.direction),this._super(t,e),"disabled"===t?(this._callChildMethod(e?"disable":"enable"),void 0):(this.refresh(),void 0)},refresh:function(){var e,i=this;this._addClass("ui-controlgroup ui-controlgroup-"+this.options.direction),"horizontal"===this.options.direction&&this._addClass(null,"ui-helper-clearfix"),this._initWidgets(),e=this.childWidgets,this.options.onlyVisible&&(e=e.filter(":visible")),e.length&&(t.each(["first","last"],function(t,s){var n=e[s]().data("ui-controlgroup-data");if(n&&i["_"+n.widgetName+"Options"]){var o=i["_"+n.widgetName+"Options"](1===e.length?"only":s);o.classes=i._resolveClassesValues(o.classes,n),n.element[n.widgetName](o)}else i._updateCornerClass(e[s](),s)}),this._callChildMethod("refresh"))}}),t.widget("ui.checkboxradio",[t.ui.formResetMixin,{version:"1.12.0",options:{disabled:null,label:null,icon:!0,classes:{"ui-checkboxradio-label":"ui-corner-all","ui-checkboxradio-icon":"ui-corner-all"}},_getCreateOptions:function(){var e,i,s=this,n=this._super()||{};return this._readType(),i=this.element.labels(),this.label=t(i[i.length-1]),this.label.length||t.error("No label found for checkboxradio widget"),this.originalLabel="",this.label.contents().not(this.element).each(function(){s.originalLabel+=3===this.nodeType?t(this).text():this.outerHTML}),this.originalLabel&&(n.label=this.originalLabel),e=this.element[0].disabled,null!=e&&(n.disabled=e),n},_create:function(){var t=this.element[0].checked;this._bindFormResetHandler(),null==this.options.disabled&&(this.options.disabled=this.element[0].disabled),this._setOption("disabled",this.options.disabled),this._addClass("ui-checkboxradio","ui-helper-hidden-accessible"),this._addClass(this.label,"ui-checkboxradio-label","ui-button ui-widget"),"radio"===this.type&&this._addClass(this.label,"ui-checkboxradio-radio-label"),this.options.label&&this.options.label!==this.originalLabel?this._updateLabel():this.originalLabel&&(this.options.label=this.originalLabel),this._enhance(),t&&(this._addClass(this.label,"ui-checkboxradio-checked","ui-state-active"),this.icon&&this._addClass(this.icon,null,"ui-state-hover")),this._on({change:"_toggleClasses",focus:function(){this._addClass(this.label,null,"ui-state-focus ui-visual-focus")},blur:function(){this._removeClass(this.label,null,"ui-state-focus ui-visual-focus")}})},_readType:function(){var e=this.element[0].nodeName.toLowerCase();this.type=this.element[0].type,"input"===e&&/radio|checkbox/.test(this.type)||t.error("Can't create checkboxradio on element.nodeName="+e+" and element.type="+this.type)},_enhance:function(){this._updateIcon(this.element[0].checked)},widget:function(){return this.label},_getRadioGroup:function(){var e,i=this.element[0].name,s="input[name='"+t.ui.escapeSelector(i)+"']";return i?(e=this.form.length?t(this.form[0].elements).filter(s):t(s).filter(function(){return 0===t(this).form().length}),e.not(this.element)):t([])},_toggleClasses:function(){var e=this.element[0].checked;this._toggleClass(this.label,"ui-checkboxradio-checked","ui-state-active",e),this.options.icon&&"checkbox"===this.type&&this._toggleClass(this.icon,null,"ui-icon-check ui-state-checked",e)._toggleClass(this.icon,null,"ui-icon-blank",!e),"radio"===this.type&&this._getRadioGroup().each(function(){var e=t(this).checkboxradio("instance");e&&e._removeClass(e.label,"ui-checkboxradio-checked","ui-state-active")})},_destroy:function(){this._unbindFormResetHandler(),this.icon&&(this.icon.remove(),this.iconSpace.remove())},_setOption:function(t,e){return"label"!==t||e?(this._super(t,e),"disabled"===t?(this._toggleClass(this.label,null,"ui-state-disabled",e),this.element[0].disabled=e,void 0):(this.refresh(),void 0)):void 0},_updateIcon:function(e){var i="ui-icon ui-icon-background ";
    this.options.icon?(this.icon||(this.icon=t("<span>"),this.iconSpace=t("<span> </span>"),this._addClass(this.iconSpace,"ui-checkboxradio-icon-space")),"checkbox"===this.type?(i+=e?"ui-icon-check ui-state-checked":"ui-icon-blank",this._removeClass(this.icon,null,e?"ui-icon-blank":"ui-icon-check")):i+="ui-icon-blank",this._addClass(this.icon,"ui-checkboxradio-icon",i),e||this._removeClass(this.icon,null,"ui-icon-check ui-state-checked"),this.icon.prependTo(this.label).after(this.iconSpace)):void 0!==this.icon&&(this.icon.remove(),this.iconSpace.remove(),delete this.icon)},_updateLabel:function(){this.label.contents().not(this.element.add(this.icon).add(this.iconSpace)).remove(),this.label.append(this.options.label)},refresh:function(){var t=this.element[0].checked,e=this.element[0].disabled;this._updateIcon(t),this._toggleClass(this.label,"ui-checkboxradio-checked","ui-state-active",t),null!==this.options.label&&this._updateLabel(),e!==this.options.disabled&&this._setOptions({disabled:e})}}]),t.ui.checkboxradio,t.widget("ui.button",{version:"1.12.0",defaultElement:"<button>",options:{classes:{"ui-button":"ui-corner-all"},disabled:null,icon:null,iconPosition:"beginning",label:null,showLabel:!0},_getCreateOptions:function(){var t,e=this._super()||{};return this.isInput=this.element.is("input"),t=this.element[0].disabled,null!=t&&(e.disabled=t),this.originalLabel=this.isInput?this.element.val():this.element.html(),this.originalLabel&&(e.label=this.originalLabel),e},_create:function(){!this.option.showLabel&!this.options.icon&&(this.options.showLabel=!0),null==this.options.disabled&&(this.options.disabled=this.element[0].disabled||!1),this.hasTitle=!!this.element.attr("title"),this.options.label&&this.options.label!==this.originalLabel&&(this.isInput?this.element.val(this.options.label):this.element.html(this.options.label)),this._addClass("ui-button","ui-widget"),this._setOption("disabled",this.options.disabled),this._enhance(),this.element.is("a")&&this._on({keyup:function(e){e.keyCode===t.ui.keyCode.SPACE&&(e.preventDefault(),this.element[0].click?this.element[0].click():this.element.trigger("click"))}})},_enhance:function(){this.element.is("button")||this.element.attr("role","button"),this.options.icon&&(this._updateIcon("icon",this.options.icon),this._updateTooltip())},_updateTooltip:function(){this.title=this.element.attr("title"),this.options.showLabel||this.title||this.element.attr("title",this.options.label)},_updateIcon:function(e,i){var s="iconPosition"!==e,n=s?this.options.iconPosition:i,o="top"===n||"bottom"===n;this.icon?s&&this._removeClass(this.icon,null,this.options.icon):(this.icon=t("<span>"),this._addClass(this.icon,"ui-button-icon","ui-icon"),this.options.showLabel||this._addClass("ui-button-icon-only")),s&&this._addClass(this.icon,null,i),this._attachIcon(n),o?(this._addClass(this.icon,null,"ui-widget-icon-block"),this.iconSpace&&this.iconSpace.remove()):(this.iconSpace||(this.iconSpace=t("<span> </span>"),this._addClass(this.iconSpace,"ui-button-icon-space")),this._removeClass(this.icon,null,"ui-wiget-icon-block"),this._attachIconSpace(n))},_destroy:function(){this.element.removeAttr("role"),this.icon&&this.icon.remove(),this.iconSpace&&this.iconSpace.remove(),this.hasTitle||this.element.removeAttr("title")},_attachIconSpace:function(t){this.icon[/^(?:end|bottom)/.test(t)?"before":"after"](this.iconSpace)},_attachIcon:function(t){this.element[/^(?:end|bottom)/.test(t)?"append":"prepend"](this.icon)},_setOptions:function(t){var e=void 0===t.showLabel?this.options.showLabel:t.showLabel,i=void 0===t.icon?this.options.icon:t.icon;e||i||(t.showLabel=!0),this._super(t)},_setOption:function(t,e){"icon"===t&&(e?this._updateIcon(t,e):this.icon&&(this.icon.remove(),this.iconSpace&&this.iconSpace.remove())),"iconPosition"===t&&this._updateIcon(t,e),"showLabel"===t&&(this._toggleClass("ui-button-icon-only",null,!e),this._updateTooltip()),"label"===t&&(this.isInput?this.element.val(e):(this.element.html(e),this.icon&&(this._attachIcon(this.options.iconPosition),this._attachIconSpace(this.options.iconPosition)))),this._super(t,e),"disabled"===t&&(this._toggleClass(null,"ui-state-disabled",e),this.element[0].disabled=e,e&&this.element.blur())},refresh:function(){var t=this.element.is("input, button")?this.element[0].disabled:this.element.hasClass("ui-button-disabled");t!==this.options.disabled&&this._setOptions({disabled:t}),this._updateTooltip()}}),t.uiBackCompat!==!1&&(t.widget("ui.button",t.ui.button,{options:{text:!0,icons:{primary:null,secondary:null}},_create:function(){this.options.showLabel&&!this.options.text&&(this.options.showLabel=this.options.text),!this.options.showLabel&&this.options.text&&(this.options.text=this.options.showLabel),this.options.icon||!this.options.icons.primary&&!this.options.icons.secondary?this.options.icon&&(this.options.icons.primary=this.options.icon):this.options.icons.primary?this.options.icon=this.options.icons.primary:(this.options.icon=this.options.icons.secondary,this.options.iconPosition="end"),this._super()},_setOption:function(t,e){return"text"===t?(this._super("showLabel",e),void 0):("showLabel"===t&&(this.options.text=e),"icon"===t&&(this.options.icons.primary=e),"icons"===t&&(e.primary?(this._super("icon",e.primary),this._super("iconPosition","beginning")):e.secondary&&(this._super("icon",e.secondary),this._super("iconPosition","end"))),this._superApply(arguments),void 0)}}),t.fn.button=function(e){return function(){return!this.length||this.length&&"INPUT"!==this[0].tagName||this.length&&"INPUT"===this[0].tagName&&"checkbox"!==this.attr("type")&&"radio"!==this.attr("type")?e.apply(this,arguments):(t.ui.checkboxradio||t.error("Checkboxradio widget missing"),0===arguments.length?this.checkboxradio({icon:!1}):this.checkboxradio.apply(this,arguments))}}(t.fn.button),t.fn.buttonset=function(){return t.ui.controlgroup||t.error("Controlgroup widget missing"),"option"===arguments[0]&&"items"===arguments[1]&&arguments[2]?this.controlgroup.apply(this,[arguments[0],"items.button",arguments[2]]):"option"===arguments[0]&&"items"===arguments[1]?this.controlgroup.apply(this,[arguments[0],"items.button"]):("object"==typeof arguments[0]&&arguments[0].items&&(arguments[0].items={button:arguments[0].items}),this.controlgroup.apply(this,arguments))}),t.ui.button,t.widget("ui.dialog",{version:"1.12.0",options:{appendTo:"body",autoOpen:!0,buttons:[],classes:{"ui-dialog":"ui-corner-all","ui-dialog-titlebar":"ui-corner-all"},closeOnEscape:!0,closeText:"Close",draggable:!0,hide:null,height:"auto",maxHeight:null,maxWidth:null,minHeight:150,minWidth:150,modal:!1,position:{my:"center",at:"center",of:window,collision:"fit",using:function(e){var i=t(this).css(e).offset().top;0>i&&t(this).css("top",e.top-i)}},resizable:!0,show:null,title:null,width:300,beforeClose:null,close:null,drag:null,dragStart:null,dragStop:null,focus:null,open:null,resize:null,resizeStart:null,resizeStop:null},sizeRelatedOptions:{buttons:!0,height:!0,maxHeight:!0,maxWidth:!0,minHeight:!0,minWidth:!0,width:!0},resizableRelatedOptions:{maxHeight:!0,maxWidth:!0,minHeight:!0,minWidth:!0},_create:function(){this.originalCss={display:this.element[0].style.display,width:this.element[0].style.width,minHeight:this.element[0].style.minHeight,maxHeight:this.element[0].style.maxHeight,height:this.element[0].style.height},this.originalPosition={parent:this.element.parent(),index:this.element.parent().children().index(this.element)},this.originalTitle=this.element.attr("title"),null==this.options.title&&null!=this.originalTitle&&(this.options.title=this.originalTitle),this.options.disabled&&(this.options.disabled=!1),this._createWrapper(),this.element.show().removeAttr("title").appendTo(this.uiDialog),this._addClass("ui-dialog-content","ui-widget-content"),this._createTitlebar(),this._createButtonPane(),this.options.draggable&&t.fn.draggable&&this._makeDraggable(),this.options.resizable&&t.fn.resizable&&this._makeResizable(),this._isOpen=!1,this._trackFocus()},_init:function(){this.options.autoOpen&&this.open()},_appendTo:function(){var e=this.options.appendTo;return e&&(e.jquery||e.nodeType)?t(e):this.document.find(e||"body").eq(0)},_destroy:function(){var t,e=this.originalPosition;this._untrackInstance(),this._destroyOverlay(),this.element.removeUniqueId().css(this.originalCss).detach(),this.uiDialog.remove(),this.originalTitle&&this.element.attr("title",this.originalTitle),t=e.parent.children().eq(e.index),t.length&&t[0]!==this.element[0]?t.before(this.element):e.parent.append(this.element)},widget:function(){return this.uiDialog},disable:t.noop,enable:t.noop,close:function(e){var i=this;this._isOpen&&this._trigger("beforeClose",e)!==!1&&(this._isOpen=!1,this._focusedElement=null,this._destroyOverlay(),this._untrackInstance(),this.opener.filter(":focusable").trigger("focus").length||t.ui.safeBlur(t.ui.safeActiveElement(this.document[0])),this._hide(this.uiDialog,this.options.hide,function(){i._trigger("close",e)}))},isOpen:function(){return this._isOpen},moveToTop:function(){this._moveToTop()},_moveToTop:function(e,i){var s=!1,n=this.uiDialog.siblings(".ui-front:visible").map(function(){return+t(this).css("z-index")}).get(),o=Math.max.apply(null,n);return o>=+this.uiDialog.css("z-index")&&(this.uiDialog.css("z-index",o+1),s=!0),s&&!i&&this._trigger("focus",e),s},open:function(){var e=this;return this._isOpen?(this._moveToTop()&&this._focusTabbable(),void 0):(this._isOpen=!0,this.opener=t(t.ui.safeActiveElement(this.document[0])),this._size(),this._position(),this._createOverlay(),this._moveToTop(null,!0),this.overlay&&this.overlay.css("z-index",this.uiDialog.css("z-index")-1),this._show(this.uiDialog,this.options.show,function(){e._focusTabbable(),e._trigger("focus")}),this._makeFocusTarget(),this._trigger("open"),void 0)},_focusTabbable:function(){var t=this._focusedElement;t||(t=this.element.find("[autofocus]")),t.length||(t=this.element.find(":tabbable")),t.length||(t=this.uiDialogButtonPane.find(":tabbable")),t.length||(t=this.uiDialogTitlebarClose.filter(":tabbable")),t.length||(t=this.uiDialog),t.eq(0).trigger("focus")},_keepFocus:function(e){function i(){var e=t.ui.safeActiveElement(this.document[0]),i=this.uiDialog[0]===e||t.contains(this.uiDialog[0],e);i||this._focusTabbable()}e.preventDefault(),i.call(this),this._delay(i)},_createWrapper:function(){this.uiDialog=t("<div>").hide().attr({tabIndex:-1,role:"dialog"}).appendTo(this._appendTo()),this._addClass(this.uiDialog,"ui-dialog","ui-widget ui-widget-content ui-front"),this._on(this.uiDialog,{keydown:function(e){if(this.options.closeOnEscape&&!e.isDefaultPrevented()&&e.keyCode&&e.keyCode===t.ui.keyCode.ESCAPE)return e.preventDefault(),this.close(e),void 0;if(e.keyCode===t.ui.keyCode.TAB&&!e.isDefaultPrevented()){var i=this.uiDialog.find(":tabbable"),s=i.filter(":first"),n=i.filter(":last");e.target!==n[0]&&e.target!==this.uiDialog[0]||e.shiftKey?e.target!==s[0]&&e.target!==this.uiDialog[0]||!e.shiftKey||(this._delay(function(){n.trigger("focus")}),e.preventDefault()):(this._delay(function(){s.trigger("focus")}),e.preventDefault())}},mousedown:function(t){this._moveToTop(t)&&this._focusTabbable()}}),this.element.find("[aria-describedby]").length||this.uiDialog.attr({"aria-describedby":this.element.uniqueId().attr("id")})},_createTitlebar:function(){var e;this.uiDialogTitlebar=t("<div>"),this._addClass(this.uiDialogTitlebar,"ui-dialog-titlebar","ui-widget-header ui-helper-clearfix"),this._on(this.uiDialogTitlebar,{mousedown:function(e){t(e.target).closest(".ui-dialog-titlebar-close")||this.uiDialog.trigger("focus")}}),this.uiDialogTitlebarClose=t("<button type='button'></button>").button({label:t("<a>").text(this.options.closeText).html(),icon:"ui-icon-closethick",showLabel:!1}).appendTo(this.uiDialogTitlebar),this._addClass(this.uiDialogTitlebarClose,"ui-dialog-titlebar-close"),this._on(this.uiDialogTitlebarClose,{click:function(t){t.preventDefault(),this.close(t)}}),e=t("<span>").uniqueId().prependTo(this.uiDialogTitlebar),this._addClass(e,"ui-dialog-title"),this._title(e),this.uiDialogTitlebar.prependTo(this.uiDialog),this.uiDialog.attr({"aria-labelledby":e.attr("id")})},_title:function(t){this.options.title?t.text(this.options.title):t.html("&#160;")},_createButtonPane:function(){this.uiDialogButtonPane=t("<div>"),this._addClass(this.uiDialogButtonPane,"ui-dialog-buttonpane","ui-widget-content ui-helper-clearfix"),this.uiButtonSet=t("<div>").appendTo(this.uiDialogButtonPane),this._addClass(this.uiButtonSet,"ui-dialog-buttonset"),this._createButtons()},_createButtons:function(){var e=this,i=this.options.buttons;return this.uiDialogButtonPane.remove(),this.uiButtonSet.empty(),t.isEmptyObject(i)||t.isArray(i)&&!i.length?(this._removeClass(this.uiDialog,"ui-dialog-buttons"),void 0):(t.each(i,function(i,s){var n,o;s=t.isFunction(s)?{click:s,text:i}:s,s=t.extend({type:"button"},s),n=s.click,o={icon:s.icon,iconPosition:s.iconPosition,showLabel:s.showLabel},delete s.click,delete s.icon,delete s.iconPosition,delete s.showLabel,t("<button></button>",s).button(o).appendTo(e.uiButtonSet).on("click",function(){n.apply(e.element[0],arguments)})}),this._addClass(this.uiDialog,"ui-dialog-buttons"),this.uiDialogButtonPane.appendTo(this.uiDialog),void 0)},_makeDraggable:function(){function e(t){return{position:t.position,offset:t.offset}}var i=this,s=this.options;this.uiDialog.draggable({cancel:".ui-dialog-content, .ui-dialog-titlebar-close",handle:".ui-dialog-titlebar",containment:"document",start:function(s,n){i._addClass(t(this),"ui-dialog-dragging"),i._blockFrames(),i._trigger("dragStart",s,e(n))},drag:function(t,s){i._trigger("drag",t,e(s))},stop:function(n,o){var a=o.offset.left-i.document.scrollLeft(),r=o.offset.top-i.document.scrollTop();s.position={my:"left top",at:"left"+(a>=0?"+":"")+a+" "+"top"+(r>=0?"+":"")+r,of:i.window},i._removeClass(t(this),"ui-dialog-dragging"),i._unblockFrames(),i._trigger("dragStop",n,e(o))}})},_makeResizable:function(){function e(t){return{originalPosition:t.originalPosition,originalSize:t.originalSize,position:t.position,size:t.size}}var i=this,s=this.options,n=s.resizable,o=this.uiDialog.css("position"),a="string"==typeof n?n:"n,e,s,w,se,sw,ne,nw";this.uiDialog.resizable({cancel:".ui-dialog-content",containment:"document",alsoResize:this.element,maxWidth:s.maxWidth,maxHeight:s.maxHeight,minWidth:s.minWidth,minHeight:this._minHeight(),handles:a,start:function(s,n){i._addClass(t(this),"ui-dialog-resizing"),i._blockFrames(),i._trigger("resizeStart",s,e(n))},resize:function(t,s){i._trigger("resize",t,e(s))},stop:function(n,o){var a=i.uiDialog.offset(),r=a.left-i.document.scrollLeft(),h=a.top-i.document.scrollTop();s.height=i.uiDialog.height(),s.width=i.uiDialog.width(),s.position={my:"left top",at:"left"+(r>=0?"+":"")+r+" "+"top"+(h>=0?"+":"")+h,of:i.window},i._removeClass(t(this),"ui-dialog-resizing"),i._unblockFrames(),i._trigger("resizeStop",n,e(o))}}).css("position",o)},_trackFocus:function(){this._on(this.widget(),{focusin:function(e){this._makeFocusTarget(),this._focusedElement=t(e.target)}})},_makeFocusTarget:function(){this._untrackInstance(),this._trackingInstances().unshift(this)},_untrackInstance:function(){var e=this._trackingInstances(),i=t.inArray(this,e);-1!==i&&e.splice(i,1)},_trackingInstances:function(){var t=this.document.data("ui-dialog-instances");return t||(t=[],this.document.data("ui-dialog-instances",t)),t},_minHeight:function(){var t=this.options;return"auto"===t.height?t.minHeight:Math.min(t.minHeight,t.height)},_position:function(){var t=this.uiDialog.is(":visible");t||this.uiDialog.show(),this.uiDialog.position(this.options.position),t||this.uiDialog.hide()},_setOptions:function(e){var i=this,s=!1,n={};t.each(e,function(t,e){i._setOption(t,e),t in i.sizeRelatedOptions&&(s=!0),t in i.resizableRelatedOptions&&(n[t]=e)}),s&&(this._size(),this._position()),this.uiDialog.is(":data(ui-resizable)")&&this.uiDialog.resizable("option",n)},_setOption:function(e,i){var s,n,o=this.uiDialog;"disabled"!==e&&(this._super(e,i),"appendTo"===e&&this.uiDialog.appendTo(this._appendTo()),"buttons"===e&&this._createButtons(),"closeText"===e&&this.uiDialogTitlebarClose.button({label:t("<a>").text(""+this.options.closeText).html()}),"draggable"===e&&(s=o.is(":data(ui-draggable)"),s&&!i&&o.draggable("destroy"),!s&&i&&this._makeDraggable()),"position"===e&&this._position(),"resizable"===e&&(n=o.is(":data(ui-resizable)"),n&&!i&&o.resizable("destroy"),n&&"string"==typeof i&&o.resizable("option","handles",i),n||i===!1||this._makeResizable()),"title"===e&&this._title(this.uiDialogTitlebar.find(".ui-dialog-title")))},_size:function(){var t,e,i,s=this.options;this.element.show().css({width:"auto",minHeight:0,maxHeight:"none",height:0}),s.minWidth>s.width&&(s.width=s.minWidth),t=this.uiDialog.css({height:"auto",width:s.width}).outerHeight(),e=Math.max(0,s.minHeight-t),i="number"==typeof s.maxHeight?Math.max(0,s.maxHeight-t):"none","auto"===s.height?this.element.css({minHeight:e,maxHeight:i,height:"auto"}):this.element.height(Math.max(0,s.height-t)),this.uiDialog.is(":data(ui-resizable)")&&this.uiDialog.resizable("option","minHeight",this._minHeight())},_blockFrames:function(){this.iframeBlocks=this.document.find("iframe").map(function(){var e=t(this);return t("<div>").css({position:"absolute",width:e.outerWidth(),height:e.outerHeight()}).appendTo(e.parent()).offset(e.offset())[0]})},_unblockFrames:function(){this.iframeBlocks&&(this.iframeBlocks.remove(),delete this.iframeBlocks)},_allowInteraction:function(e){return t(e.target).closest(".ui-dialog").length?!0:!!t(e.target).closest(".ui-datepicker").length},_createOverlay:function(){if(this.options.modal){var e=!0;this._delay(function(){e=!1}),this.document.data("ui-dialog-overlays")||this._on(this.document,{focusin:function(t){e||this._allowInteraction(t)||(t.preventDefault(),this._trackingInstances()[0]._focusTabbable())}}),this.overlay=t("<div>").appendTo(this._appendTo()),this._addClass(this.overlay,null,"ui-widget-overlay ui-front"),this._on(this.overlay,{mousedown:"_keepFocus"}),this.document.data("ui-dialog-overlays",(this.document.data("ui-dialog-overlays")||0)+1)}},_destroyOverlay:function(){if(this.options.modal&&this.overlay){var t=this.document.data("ui-dialog-overlays")-1;t?this.document.data("ui-dialog-overlays",t):(this._off(this.document,"focusin"),this.document.removeData("ui-dialog-overlays")),this.overlay.remove(),this.overlay=null}}}),t.uiBackCompat!==!1&&t.widget("ui.dialog",t.ui.dialog,{options:{dialogClass:""},_createWrapper:function(){this._super(),this.uiDialog.addClass(this.options.dialogClass)},_setOption:function(t,e){"dialogClass"===t&&this.uiDialog.removeClass(this.options.dialogClass).addClass(e),this._superApply(arguments)}}),t.ui.dialog,t.widget("ui.slider",t.ui.mouse,{version:"1.12.0",widgetEventPrefix:"slide",options:{animate:!1,classes:{"ui-slider":"ui-corner-all","ui-slider-handle":"ui-corner-all","ui-slider-range":"ui-corner-all ui-widget-header"},distance:0,max:100,min:0,orientation:"horizontal",range:!1,step:1,value:0,values:null,change:null,slide:null,start:null,stop:null},numPages:5,_create:function(){this._keySliding=!1,this._mouseSliding=!1,this._animateOff=!0,this._handleIndex=null,this._detectOrientation(),this._mouseInit(),this._calculateNewMax(),this._addClass("ui-slider ui-slider-"+this.orientation,"ui-widget ui-widget-content"),this._refresh(),this._animateOff=!1},_refresh:function(){this._createRange(),this._createHandles(),this._setupEvents(),this._refreshValue()},_createHandles:function(){var e,i,s=this.options,n=this.element.find(".ui-slider-handle"),o="<span tabindex='0'></span>",a=[];for(i=s.values&&s.values.length||1,n.length>i&&(n.slice(i).remove(),n=n.slice(0,i)),e=n.length;i>e;e++)a.push(o);this.handles=n.add(t(a.join("")).appendTo(this.element)),this._addClass(this.handles,"ui-slider-handle","ui-state-default"),this.handle=this.handles.eq(0),this.handles.each(function(e){t(this).data("ui-slider-handle-index",e)})},_createRange:function(){var e=this.options;e.range?(e.range===!0&&(e.values?e.values.length&&2!==e.values.length?e.values=[e.values[0],e.values[0]]:t.isArray(e.values)&&(e.values=e.values.slice(0)):e.values=[this._valueMin(),this._valueMin()]),this.range&&this.range.length?(this._removeClass(this.range,"ui-slider-range-min ui-slider-range-max"),this.range.css({left:"",bottom:""})):(this.range=t("<div>").appendTo(this.element),this._addClass(this.range,"ui-slider-range")),("min"===e.range||"max"===e.range)&&this._addClass(this.range,"ui-slider-range-"+e.range)):(this.range&&this.range.remove(),this.range=null)},_setupEvents:function(){this._off(this.handles),this._on(this.handles,this._handleEvents),this._hoverable(this.handles),this._focusable(this.handles)},_destroy:function(){this.handles.remove(),this.range&&this.range.remove(),this._mouseDestroy()},_mouseCapture:function(e){var i,s,n,o,a,r,h,l,c=this,u=this.options;return u.disabled?!1:(this.elementSize={width:this.element.outerWidth(),height:this.element.outerHeight()},this.elementOffset=this.element.offset(),i={x:e.pageX,y:e.pageY},s=this._normValueFromMouse(i),n=this._valueMax()-this._valueMin()+1,this.handles.each(function(e){var i=Math.abs(s-c.values(e));(n>i||n===i&&(e===c._lastChangedValue||c.values(e)===u.min))&&(n=i,o=t(this),a=e)}),r=this._start(e,a),r===!1?!1:(this._mouseSliding=!0,this._handleIndex=a,this._addClass(o,null,"ui-state-active"),o.trigger("focus"),h=o.offset(),l=!t(e.target).parents().addBack().is(".ui-slider-handle"),this._clickOffset=l?{left:0,top:0}:{left:e.pageX-h.left-o.width()/2,top:e.pageY-h.top-o.height()/2-(parseInt(o.css("borderTopWidth"),10)||0)-(parseInt(o.css("borderBottomWidth"),10)||0)+(parseInt(o.css("marginTop"),10)||0)},this.handles.hasClass("ui-state-hover")||this._slide(e,a,s),this._animateOff=!0,!0))},_mouseStart:function(){return!0},_mouseDrag:function(t){var e={x:t.pageX,y:t.pageY},i=this._normValueFromMouse(e);return this._slide(t,this._handleIndex,i),!1},_mouseStop:function(t){return this._removeClass(this.handles,null,"ui-state-active"),this._mouseSliding=!1,this._stop(t,this._handleIndex),this._change(t,this._handleIndex),this._handleIndex=null,this._clickOffset=null,this._animateOff=!1,!1},_detectOrientation:function(){this.orientation="vertical"===this.options.orientation?"vertical":"horizontal"},_normValueFromMouse:function(t){var e,i,s,n,o;return"horizontal"===this.orientation?(e=this.elementSize.width,i=t.x-this.elementOffset.left-(this._clickOffset?this._clickOffset.left:0)):(e=this.elementSize.height,i=t.y-this.elementOffset.top-(this._clickOffset?this._clickOffset.top:0)),s=i/e,s>1&&(s=1),0>s&&(s=0),"vertical"===this.orientation&&(s=1-s),n=this._valueMax()-this._valueMin(),o=this._valueMin()+s*n,this._trimAlignValue(o)},_uiHash:function(t,e,i){var s={handle:this.handles[t],handleIndex:t,value:void 0!==e?e:this.value()};return this._hasMultipleValues()&&(s.value=void 0!==e?e:this.values(t),s.values=i||this.values()),s},_hasMultipleValues:function(){return this.options.values&&this.options.values.length},_start:function(t,e){return this._trigger("start",t,this._uiHash(e))},_slide:function(t,e,i){var s,n,o=this.value(),a=this.values();this._hasMultipleValues()&&(n=this.values(e?0:1),o=this.values(e),2===this.options.values.length&&this.options.range===!0&&(i=0===e?Math.min(n,i):Math.max(n,i)),a[e]=i),i!==o&&(s=this._trigger("slide",t,this._uiHash(e,i,a)),s!==!1&&(this._hasMultipleValues()?this.values(e,i):this.value(i)))},_stop:function(t,e){this._trigger("stop",t,this._uiHash(e))},_change:function(t,e){this._keySliding||this._mouseSliding||(this._lastChangedValue=e,this._trigger("change",t,this._uiHash(e)))},value:function(t){return arguments.length?(this.options.value=this._trimAlignValue(t),this._refreshValue(),this._change(null,0),void 0):this._value()},values:function(e,i){var s,n,o;if(arguments.length>1)return this.options.values[e]=this._trimAlignValue(i),this._refreshValue(),this._change(null,e),void 0;if(!arguments.length)return this._values();if(!t.isArray(arguments[0]))return this._hasMultipleValues()?this._values(e):this.value();for(s=this.options.values,n=arguments[0],o=0;s.length>o;o+=1)s[o]=this._trimAlignValue(n[o]),this._change(null,o);this._refreshValue()},_setOption:function(e,i){var s,n=0;switch("range"===e&&this.options.range===!0&&("min"===i?(this.options.value=this._values(0),this.options.values=null):"max"===i&&(this.options.value=this._values(this.options.values.length-1),this.options.values=null)),t.isArray(this.options.values)&&(n=this.options.values.length),this._super(e,i),e){case"orientation":this._detectOrientation(),this._removeClass("ui-slider-horizontal ui-slider-vertical")._addClass("ui-slider-"+this.orientation),this._refreshValue(),this.options.range&&this._refreshRange(i),this.handles.css("horizontal"===i?"bottom":"left","");break;case"value":this._animateOff=!0,this._refreshValue(),this._change(null,0),this._animateOff=!1;break;case"values":for(this._animateOff=!0,this._refreshValue(),s=n-1;s>=0;s--)this._change(null,s);this._animateOff=!1;break;case"step":case"min":case"max":this._animateOff=!0,this._calculateNewMax(),this._refreshValue(),this._animateOff=!1;break;case"range":this._animateOff=!0,this._refresh(),this._animateOff=!1}},_setOptionDisabled:function(t){this._super(t),this._toggleClass(null,"ui-state-disabled",!!t)},_value:function(){var t=this.options.value;return t=this._trimAlignValue(t)},_values:function(t){var e,i,s;if(arguments.length)return e=this.options.values[t],e=this._trimAlignValue(e);if(this._hasMultipleValues()){for(i=this.options.values.slice(),s=0;i.length>s;s+=1)i[s]=this._trimAlignValue(i[s]);return i}return[]},_trimAlignValue:function(t){if(this._valueMin()>=t)return this._valueMin();if(t>=this._valueMax())return this._valueMax();var e=this.options.step>0?this.options.step:1,i=(t-this._valueMin())%e,s=t-i;return 2*Math.abs(i)>=e&&(s+=i>0?e:-e),parseFloat(s.toFixed(5))},_calculateNewMax:function(){var t=this.options.max,e=this._valueMin(),i=this.options.step,s=Math.round((t-e)/i)*i;t=s+e,t>this.options.max&&(t-=i),this.max=parseFloat(t.toFixed(this._precision()))},_precision:function(){var t=this._precisionOf(this.options.step);return null!==this.options.min&&(t=Math.max(t,this._precisionOf(this.options.min))),t},_precisionOf:function(t){var e=""+t,i=e.indexOf(".");return-1===i?0:e.length-i-1},_valueMin:function(){return this.options.min},_valueMax:function(){return this.max},_refreshRange:function(t){"vertical"===t&&this.range.css({width:"",left:""}),"horizontal"===t&&this.range.css({height:"",bottom:""})},_refreshValue:function(){var e,i,s,n,o,a=this.options.range,r=this.options,h=this,l=this._animateOff?!1:r.animate,c={};this._hasMultipleValues()?this.handles.each(function(s){i=100*((h.values(s)-h._valueMin())/(h._valueMax()-h._valueMin())),c["horizontal"===h.orientation?"left":"bottom"]=i+"%",t(this).stop(1,1)[l?"animate":"css"](c,r.animate),h.options.range===!0&&("horizontal"===h.orientation?(0===s&&h.range.stop(1,1)[l?"animate":"css"]({left:i+"%"},r.animate),1===s&&h.range[l?"animate":"css"]({width:i-e+"%"},{queue:!1,duration:r.animate})):(0===s&&h.range.stop(1,1)[l?"animate":"css"]({bottom:i+"%"},r.animate),1===s&&h.range[l?"animate":"css"]({height:i-e+"%"},{queue:!1,duration:r.animate}))),e=i}):(s=this.value(),n=this._valueMin(),o=this._valueMax(),i=o!==n?100*((s-n)/(o-n)):0,c["horizontal"===this.orientation?"left":"bottom"]=i+"%",this.handle.stop(1,1)[l?"animate":"css"](c,r.animate),"min"===a&&"horizontal"===this.orientation&&this.range.stop(1,1)[l?"animate":"css"]({width:i+"%"},r.animate),"max"===a&&"horizontal"===this.orientation&&this.range.stop(1,1)[l?"animate":"css"]({width:100-i+"%"},r.animate),"min"===a&&"vertical"===this.orientation&&this.range.stop(1,1)[l?"animate":"css"]({height:i+"%"},r.animate),"max"===a&&"vertical"===this.orientation&&this.range.stop(1,1)[l?"animate":"css"]({height:100-i+"%"},r.animate))},_handleEvents:{keydown:function(e){var i,s,n,o,a=t(e.target).data("ui-slider-handle-index");switch(e.keyCode){case t.ui.keyCode.HOME:case t.ui.keyCode.END:case t.ui.keyCode.PAGE_UP:case t.ui.keyCode.PAGE_DOWN:case t.ui.keyCode.UP:case t.ui.keyCode.RIGHT:case t.ui.keyCode.DOWN:case t.ui.keyCode.LEFT:if(e.preventDefault(),!this._keySliding&&(this._keySliding=!0,this._addClass(t(e.target),null,"ui-state-active"),i=this._start(e,a),i===!1))return}switch(o=this.options.step,s=n=this._hasMultipleValues()?this.values(a):this.value(),e.keyCode){case t.ui.keyCode.HOME:n=this._valueMin();break;case t.ui.keyCode.END:n=this._valueMax();break;case t.ui.keyCode.PAGE_UP:n=this._trimAlignValue(s+(this._valueMax()-this._valueMin())/this.numPages);break;case t.ui.keyCode.PAGE_DOWN:n=this._trimAlignValue(s-(this._valueMax()-this._valueMin())/this.numPages);break;case t.ui.keyCode.UP:case t.ui.keyCode.RIGHT:if(s===this._valueMax())return;n=this._trimAlignValue(s+o);break;case t.ui.keyCode.DOWN:case t.ui.keyCode.LEFT:if(s===this._valueMin())return;n=this._trimAlignValue(s-o)}this._slide(e,a,n)},keyup:function(e){var i=t(e.target).data("ui-slider-handle-index");this._keySliding&&(this._keySliding=!1,this._stop(e,i),this._change(e,i),this._removeClass(t(e.target),null,"ui-state-active"))}}}),t.widget("ui.tabs",{version:"1.12.0",delay:300,options:{active:null,classes:{"ui-tabs":"ui-corner-all","ui-tabs-nav":"ui-corner-all","ui-tabs-panel":"ui-corner-bottom","ui-tabs-tab":"ui-corner-top"},collapsible:!1,event:"click",heightStyle:"content",hide:null,show:null,activate:null,beforeActivate:null,beforeLoad:null,load:null},_isLocal:function(){var t=/#.*$/;return function(e){var i,s;i=e.href.replace(t,""),s=location.href.replace(t,"");try{i=decodeURIComponent(i)}catch(n){}try{s=decodeURIComponent(s)}catch(n){}return e.hash.length>1&&i===s}}(),_create:function(){var e=this,i=this.options;this.running=!1,this._addClass("ui-tabs","ui-widget ui-widget-content"),this._toggleClass("ui-tabs-collapsible",null,i.collapsible),this._processTabs(),i.active=this._initialActive(),t.isArray(i.disabled)&&(i.disabled=t.unique(i.disabled.concat(t.map(this.tabs.filter(".ui-state-disabled"),function(t){return e.tabs.index(t)}))).sort()),this.active=this.options.active!==!1&&this.anchors.length?this._findActive(i.active):t(),this._refresh(),this.active.length&&this.load(i.active)},_initialActive:function(){var e=this.options.active,i=this.options.collapsible,s=location.hash.substring(1);return null===e&&(s&&this.tabs.each(function(i,n){return t(n).attr("aria-controls")===s?(e=i,!1):void 0}),null===e&&(e=this.tabs.index(this.tabs.filter(".ui-tabs-active"))),(null===e||-1===e)&&(e=this.tabs.length?0:!1)),e!==!1&&(e=this.tabs.index(this.tabs.eq(e)),-1===e&&(e=i?!1:0)),!i&&e===!1&&this.anchors.length&&(e=0),e},_getCreateEventData:function(){return{tab:this.active,panel:this.active.length?this._getPanelForTab(this.active):t()}},_tabKeydown:function(e){var i=t(t.ui.safeActiveElement(this.document[0])).closest("li"),s=this.tabs.index(i),n=!0;if(!this._handlePageNav(e)){switch(e.keyCode){case t.ui.keyCode.RIGHT:case t.ui.keyCode.DOWN:s++;break;case t.ui.keyCode.UP:case t.ui.keyCode.LEFT:n=!1,s--;break;case t.ui.keyCode.END:s=this.anchors.length-1;break;case t.ui.keyCode.HOME:s=0;break;case t.ui.keyCode.SPACE:return e.preventDefault(),clearTimeout(this.activating),this._activate(s),void 0;case t.ui.keyCode.ENTER:return e.preventDefault(),clearTimeout(this.activating),this._activate(s===this.options.active?!1:s),void 0;default:return}e.preventDefault(),clearTimeout(this.activating),s=this._focusNextTab(s,n),e.ctrlKey||e.metaKey||(i.attr("aria-selected","false"),this.tabs.eq(s).attr("aria-selected","true"),this.activating=this._delay(function(){this.option("active",s)},this.delay))}},_panelKeydown:function(e){this._handlePageNav(e)||e.ctrlKey&&e.keyCode===t.ui.keyCode.UP&&(e.preventDefault(),this.active.trigger("focus"))},_handlePageNav:function(e){return e.altKey&&e.keyCode===t.ui.keyCode.PAGE_UP?(this._activate(this._focusNextTab(this.options.active-1,!1)),!0):e.altKey&&e.keyCode===t.ui.keyCode.PAGE_DOWN?(this._activate(this._focusNextTab(this.options.active+1,!0)),!0):void 0
},_findNextTab:function(e,i){function s(){return e>n&&(e=0),0>e&&(e=n),e}for(var n=this.tabs.length-1;-1!==t.inArray(s(),this.options.disabled);)e=i?e+1:e-1;return e},_focusNextTab:function(t,e){return t=this._findNextTab(t,e),this.tabs.eq(t).trigger("focus"),t},_setOption:function(t,e){return"active"===t?(this._activate(e),void 0):(this._super(t,e),"collapsible"===t&&(this._toggleClass("ui-tabs-collapsible",null,e),e||this.options.active!==!1||this._activate(0)),"event"===t&&this._setupEvents(e),"heightStyle"===t&&this._setupHeightStyle(e),void 0)},_sanitizeSelector:function(t){return t?t.replace(/[!"$%&'()*+,.\/:;<=>?@\[\]\^`{|}~]/g,"\\$&"):""},refresh:function(){var e=this.options,i=this.tablist.children(":has(a[href])");e.disabled=t.map(i.filter(".ui-state-disabled"),function(t){return i.index(t)}),this._processTabs(),e.active!==!1&&this.anchors.length?this.active.length&&!t.contains(this.tablist[0],this.active[0])?this.tabs.length===e.disabled.length?(e.active=!1,this.active=t()):this._activate(this._findNextTab(Math.max(0,e.active-1),!1)):e.active=this.tabs.index(this.active):(e.active=!1,this.active=t()),this._refresh()},_refresh:function(){this._setOptionDisabled(this.options.disabled),this._setupEvents(this.options.event),this._setupHeightStyle(this.options.heightStyle),this.tabs.not(this.active).attr({"aria-selected":"false","aria-expanded":"false",tabIndex:-1}),this.panels.not(this._getPanelForTab(this.active)).hide().attr({"aria-hidden":"true"}),this.active.length?(this.active.attr({"aria-selected":"true","aria-expanded":"true",tabIndex:0}),this._addClass(this.active,"ui-tabs-active","ui-state-active"),this._getPanelForTab(this.active).show().attr({"aria-hidden":"false"})):this.tabs.eq(0).attr("tabIndex",0)},_processTabs:function(){var e=this,i=this.tabs,s=this.anchors,n=this.panels;this.tablist=this._getList().attr("role","tablist"),this._addClass(this.tablist,"ui-tabs-nav","ui-helper-reset ui-helper-clearfix ui-widget-header"),this.tablist.on("mousedown"+this.eventNamespace,"> li",function(e){t(this).is(".ui-state-disabled")&&e.preventDefault()}).on("focus"+this.eventNamespace,".ui-tabs-anchor",function(){t(this).closest("li").is(".ui-state-disabled")&&this.blur()}),this.tabs=this.tablist.find("> li:has(a[href])").attr({role:"tab",tabIndex:-1}),this._addClass(this.tabs,"ui-tabs-tab","ui-state-default"),this.anchors=this.tabs.map(function(){return t("a",this)[0]}).attr({role:"presentation",tabIndex:-1}),this._addClass(this.anchors,"ui-tabs-anchor"),this.panels=t(),this.anchors.each(function(i,s){var n,o,a,r=t(s).uniqueId().attr("id"),h=t(s).closest("li"),l=h.attr("aria-controls");e._isLocal(s)?(n=s.hash,a=n.substring(1),o=e.element.find(e._sanitizeSelector(n))):(a=h.attr("aria-controls")||t({}).uniqueId()[0].id,n="#"+a,o=e.element.find(n),o.length||(o=e._createPanel(a),o.insertAfter(e.panels[i-1]||e.tablist)),o.attr("aria-live","polite")),o.length&&(e.panels=e.panels.add(o)),l&&h.data("ui-tabs-aria-controls",l),h.attr({"aria-controls":a,"aria-labelledby":r}),o.attr("aria-labelledby",r)}),this.panels.attr("role","tabpanel"),this._addClass(this.panels,"ui-tabs-panel","ui-widget-content"),i&&(this._off(i.not(this.tabs)),this._off(s.not(this.anchors)),this._off(n.not(this.panels)))},_getList:function(){return this.tablist||this.element.find("ol, ul").eq(0)},_createPanel:function(e){return t("<div>").attr("id",e).data("ui-tabs-destroy",!0)},_setOptionDisabled:function(e){var i,s,n;for(t.isArray(e)&&(e.length?e.length===this.anchors.length&&(e=!0):e=!1),n=0;s=this.tabs[n];n++)i=t(s),e===!0||-1!==t.inArray(n,e)?(i.attr("aria-disabled","true"),this._addClass(i,null,"ui-state-disabled")):(i.removeAttr("aria-disabled"),this._removeClass(i,null,"ui-state-disabled"));this.options.disabled=e,this._toggleClass(this.widget(),this.widgetFullName+"-disabled",null,e===!0)},_setupEvents:function(e){var i={};e&&t.each(e.split(" "),function(t,e){i[e]="_eventHandler"}),this._off(this.anchors.add(this.tabs).add(this.panels)),this._on(!0,this.anchors,{click:function(t){t.preventDefault()}}),this._on(this.anchors,i),this._on(this.tabs,{keydown:"_tabKeydown"}),this._on(this.panels,{keydown:"_panelKeydown"}),this._focusable(this.tabs),this._hoverable(this.tabs)},_setupHeightStyle:function(e){var i,s=this.element.parent();"fill"===e?(i=s.height(),i-=this.element.outerHeight()-this.element.height(),this.element.siblings(":visible").each(function(){var e=t(this),s=e.css("position");"absolute"!==s&&"fixed"!==s&&(i-=e.outerHeight(!0))}),this.element.children().not(this.panels).each(function(){i-=t(this).outerHeight(!0)}),this.panels.each(function(){t(this).height(Math.max(0,i-t(this).innerHeight()+t(this).height()))}).css("overflow","auto")):"auto"===e&&(i=0,this.panels.each(function(){i=Math.max(i,t(this).height("").height())}).height(i))},_eventHandler:function(e){var i=this.options,s=this.active,n=t(e.currentTarget),o=n.closest("li"),a=o[0]===s[0],r=a&&i.collapsible,h=r?t():this._getPanelForTab(o),l=s.length?this._getPanelForTab(s):t(),c={oldTab:s,oldPanel:l,newTab:r?t():o,newPanel:h};e.preventDefault(),o.hasClass("ui-state-disabled")||o.hasClass("ui-tabs-loading")||this.running||a&&!i.collapsible||this._trigger("beforeActivate",e,c)===!1||(i.active=r?!1:this.tabs.index(o),this.active=a?t():o,this.xhr&&this.xhr.abort(),l.length||h.length||t.error("jQuery UI Tabs: Mismatching fragment identifier."),h.length&&this.load(this.tabs.index(o),e),this._toggle(e,c))},_toggle:function(e,i){function s(){o.running=!1,o._trigger("activate",e,i)}function n(){o._addClass(i.newTab.closest("li"),"ui-tabs-active","ui-state-active"),a.length&&o.options.show?o._show(a,o.options.show,s):(a.show(),s())}var o=this,a=i.newPanel,r=i.oldPanel;this.running=!0,r.length&&this.options.hide?this._hide(r,this.options.hide,function(){o._removeClass(i.oldTab.closest("li"),"ui-tabs-active","ui-state-active"),n()}):(this._removeClass(i.oldTab.closest("li"),"ui-tabs-active","ui-state-active"),r.hide(),n()),r.attr("aria-hidden","true"),i.oldTab.attr({"aria-selected":"false","aria-expanded":"false"}),a.length&&r.length?i.oldTab.attr("tabIndex",-1):a.length&&this.tabs.filter(function(){return 0===t(this).attr("tabIndex")}).attr("tabIndex",-1),a.attr("aria-hidden","false"),i.newTab.attr({"aria-selected":"true","aria-expanded":"true",tabIndex:0})},_activate:function(e){var i,s=this._findActive(e);s[0]!==this.active[0]&&(s.length||(s=this.active),i=s.find(".ui-tabs-anchor")[0],this._eventHandler({target:i,currentTarget:i,preventDefault:t.noop}))},_findActive:function(e){return e===!1?t():this.tabs.eq(e)},_getIndex:function(e){return"string"==typeof e&&(e=this.anchors.index(this.anchors.filter("[href$='"+t.ui.escapeSelector(e)+"']"))),e},_destroy:function(){this.xhr&&this.xhr.abort(),this.tablist.removeAttr("role").off(this.eventNamespace),this.anchors.removeAttr("role tabIndex").removeUniqueId(),this.tabs.add(this.panels).each(function(){t.data(this,"ui-tabs-destroy")?t(this).remove():t(this).removeAttr("role tabIndex aria-live aria-busy aria-selected aria-labelledby aria-hidden aria-expanded")}),this.tabs.each(function(){var e=t(this),i=e.data("ui-tabs-aria-controls");i?e.attr("aria-controls",i).removeData("ui-tabs-aria-controls"):e.removeAttr("aria-controls")}),this.panels.show(),"content"!==this.options.heightStyle&&this.panels.css("height","")},enable:function(e){var i=this.options.disabled;i!==!1&&(void 0===e?i=!1:(e=this._getIndex(e),i=t.isArray(i)?t.map(i,function(t){return t!==e?t:null}):t.map(this.tabs,function(t,i){return i!==e?i:null})),this._setOptionDisabled(i))},disable:function(e){var i=this.options.disabled;if(i!==!0){if(void 0===e)i=!0;else{if(e=this._getIndex(e),-1!==t.inArray(e,i))return;i=t.isArray(i)?t.merge([e],i).sort():[e]}this._setOptionDisabled(i)}},load:function(e,i){e=this._getIndex(e);var s=this,n=this.tabs.eq(e),o=n.find(".ui-tabs-anchor"),a=this._getPanelForTab(n),r={tab:n,panel:a},h=function(t,e){"abort"===e&&s.panels.stop(!1,!0),s._removeClass(n,"ui-tabs-loading"),a.removeAttr("aria-busy"),t===s.xhr&&delete s.xhr};this._isLocal(o[0])||(this.xhr=t.ajax(this._ajaxSettings(o,i,r)),this.xhr&&"canceled"!==this.xhr.statusText&&(this._addClass(n,"ui-tabs-loading"),a.attr("aria-busy","true"),this.xhr.done(function(t,e,n){setTimeout(function(){a.html(t),s._trigger("load",i,r),h(n,e)},1)}).fail(function(t,e){setTimeout(function(){h(t,e)},1)})))},_ajaxSettings:function(e,i,s){var n=this;return{url:e.attr("href"),beforeSend:function(e,o){return n._trigger("beforeLoad",i,t.extend({jqXHR:e,ajaxSettings:o},s))}}},_getPanelForTab:function(e){var i=t(e).attr("aria-controls");return this.element.find(this._sanitizeSelector("#"+i))}}),t.uiBackCompat!==!1&&t.widget("ui.tabs",t.ui.tabs,{_processTabs:function(){this._superApply(arguments),this._addClass(this.tabs,"ui-tab")}}),t.ui.tabs});