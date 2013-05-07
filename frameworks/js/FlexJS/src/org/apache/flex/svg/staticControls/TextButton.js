/**
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

goog.provide('org.apache.flex.svg.staticControls.TextButton');

goog.require('org.apache.flex.core.UIBase');

/**
 * @constructor
 * @extends {org.apache.flex.core.UIBase}
 */
org.apache.flex.svg.staticControls.TextButton = function() {
    org.apache.flex.core.UIBase.call(this);
};
goog.inherits(
    org.apache.flex.svg.staticControls.TextButton, org.apache.flex.core.UIBase
);

/**
 * @override
 * @this {org.apache.flex.svg.staticControls.TextButton}
 * @param {Object} p The parent element.
 */
org.apache.flex.svg.staticControls.TextButton.prototype.addToParent =
    function(p) {
    this.element = document.createElement('embed');
    this.element.setAttribute('src', 'skins/TextButtonSkin.svg');
	this.element.setAttribute('type', 'button');

    p.appendChild(this.element);

    this.positioner = this.element;
};

/**
 * @expose
 * @this {org.apache.flex.svg.staticControls.TextButton}
 * @return {string} The text getter.
 */
org.apache.flex.svg.staticControls.TextButton.prototype.get_text = function() {
    return this.element.getAttribute('label');
};

/**
 * @expose
 * @this {org.apache.flex.svg.staticControls.TextButton}
 * @param {string} value The text setter.
 */
org.apache.flex.svg.staticControls.TextButton.prototype.set_text =
    function(value) {
    this.element.setAttribute('label', value);
};