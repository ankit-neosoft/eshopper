!function(t){"use strict";t.widget("ra.filteringSelect",{options:{createQuery:function(t){return{query:t}},minLength:0,searchDelay:200,remote_source:null,source:null,xhr:!1},button:null,input:null,select:null,_create:function(){var t=this.element.siblings('[data-input-for="'+this.element.attr("id")+'"]');return t.size()>0?(this.input=t.children("input"),this.button=t.children(".input-group-btn")):(this.element.hide(),t=this._inputGroup(this.element.attr("id")),this.input=this._inputField(),this.button=this._buttonField()),this._setOptionsSource(),this._initAutocomplete(),this._initKeyEvent(),this._overloadRenderItem(),this._autocompleteDropdownEvent(this.button),t.append(this.input).append(this.button).insertAfter(this.element)},_getResultSet:function(e,n,i){var o=new RegExp(t.ui.autocomplete.escapeRegex(e.term),"i"),s=function(e){return t("<span>").text(e).html()},r=function(e,n){return n.length?t.map(e.split(n),function(t){return s(t)}).join(t("<strong>").text(n)[0].outerHTML):s(e)};return t.map(n,function(t){var n=t.id||t.value,s=t.label||t.id;if(n&&(i||o.test(t.label)))return{html:r(s,e.term),value:s,id:n}})},_getSourceFunction:function(e){var n=this,i=0;return t.isArray(e)?function(t,i){i(n._getResultSet(t,e,!1))}:"string"==typeof e?function(o,s){this.xhr&&this.xhr.abort(),this.xhr=t.ajax({url:e,data:n.options.createQuery(o.term),dataType:"json",autocompleteRequest:++i,success:function(t){this.autocompleteRequest===i&&s(n._getResultSet(o,t,!0))},error:function(){this.autocompleteRequest===i&&s([])}})}:e},_setOptionsSource:function(){this.options.xhr?this.options.source=this.options.remote_source:this.options.source=this.element.children("option").map(function(){return{label:t(this).text(),value:this.value}}).toArray()},_buttonField:function(){return t('<span class="input-group-btn"><label class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-expanded="false" title="Show All Items" role="button"><span class="caret"></span><span class="ui-button-text">&nbsp;</span></label></span>')},_autocompleteDropdownEvent:function(t){var e=this;return t.click(function(){return e.input.autocomplete("widget").is(":visible")?void e.input.autocomplete("close"):(e.input.autocomplete("search",""),void e.input.focus())})},_inputField:function(){var e,n=this.element.children(":selected"),i=n.val()?n.text():"";return e=t('<input type="text">').val(i).addClass("form-control ra-filtering-select-input").attr("style",this.element.attr("style")).show(),this.element.attr("placeholder")&&e.attr("placeholder",this.element.attr("placeholder")),e},_inputGroup:function(e){return t("<div>").addClass("input-group filtering-select col-sm-2").attr("data-input-for",e).css("float","left")},_initAutocomplete:function(){var e=this;return this.input.autocomplete({delay:this.options.searchDelay,minLength:this.options.minLength,source:this._getSourceFunction(this.options.source),select:function(n,i){var o=t("<option>").attr("value",i.item.id).attr("selected","selected").text(i.item.value);e.element.html(o).trigger("change",i.item.id),e._trigger("selected",n,{item:o}),t(e.element.parents(".controls")[0]).find(".update").removeClass("disabled")},change:function(n,i){if(!i.item){var o=new RegExp("^"+t.ui.autocomplete.escapeRegex(t(this).val())+"$","i"),s=!1;if(e.element.children("option").each(function(){if(t(this).text().match(o))return s=!0,!1}),!s&&""===t(this).val())return t(this).val(null),e.element.html(t('<option value="" selected="selected"></option>')),e.input.data("ui-autocomplete").term="",t(e.element.parents(".controls")[0]).find(".update").addClass("disabled"),!1}}})},_initKeyEvent:function(){var e=this;return this.input.keyup(function(){if(!t(this).val().length)return e.element.html(t('<option value="" selected="selected"></option>')).trigger("change")})},_overloadRenderItem:function(){this.input.data("ui-autocomplete")._renderItem=function(e,n){return t("<li></li>").data("ui-autocomplete-item",n).append(t("<a></a>").html(n.html||n.id)).appendTo(e)}},destroy:function(){this.input.remove(),this.button.remove(),this.element.show(),t.Widget.prototype.destroy.call(this)}})}(jQuery);