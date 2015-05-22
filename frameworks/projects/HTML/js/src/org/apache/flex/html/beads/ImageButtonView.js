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

goog.provide('org_apache_flex_html_beads_ImageButtonView');



/**
 * @constructor
 */
org_apache_flex_html_beads_ImageButtonView = function() {
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org_apache_flex_html_beads_ImageButtonView
  .prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'ImageButtonView',
                qName: 'org_apache_flex_html_beads_ImageButtonView'}] };


Object.defineProperties(org_apache_flex_html_beads_ImageButtonView.prototype, {
    /** @expose */
    strand: {
        /** @this {org_apache_flex_html_beads_ImageButtonView} */
        set: function(value) {
            this.strand_ = value;
        }
    }
});