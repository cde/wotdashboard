/* ==========================================================
 * bootstrap-alerts.js v1.3.0
 * http://twitter.github.com/bootstrap/javascript.html#alerts
 * ==========================================================
 * Copyright 2011 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(a){var b;a(document).ready(function(){a.support.transition=function(){var a=document.body||document.documentElement,b=a.style,c=b.transition!==undefined||b.WebkitTransition!==undefined||b.MozTransition!==undefined||b.MsTransition!==undefined||b.OTransition!==undefined;return c}(),a.support.transition&&(b="TransitionEnd",a.browser.webkit?b="webkitTransitionEnd":a.browser.mozilla?b="transitionend":a.browser.opera&&(b="oTransitionEnd"))});var c=function(b,c){this.$element=a(b).delegate(c||".close","click",this.close)};c.prototype={close:function(c){function e(){d.remove()}var d=a(this).parent(".alert-message");c&&c.preventDefault(),d.removeClass("in"),a.support.transition&&d.hasClass("fade")?d.bind(b,e):e()}},a.fn.alert=function(b){return b===!0?this.data("alert"):this.each(function(){var d=a(this);if(typeof b=="string")return d.data("alert")[b]();a(this).data("alert",new c(this))})},a(document).ready(function(){new c(a("body"),".alert-message[data-alert] .close")})}(window.jQuery||window.ender)