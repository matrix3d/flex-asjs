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

goog.provide('org.apache.flex.html.accessories.PasswordInputBead');



/**
 * @constructor
 */
org.apache.flex.html.accessories.PasswordInputBead =
    function() {

  /**
   * @protected
   * @type {Object}
   */
  this.promptElement = null;
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.html.accessories.PasswordInputBead.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'PasswordInputBead',
                qName: 'org.apache.flex.html.accessories.PasswordInputBead' }] };


/**
 * @expose
 * @param {Object} value The new host.
 */
org.apache.flex.html.accessories.PasswordInputBead.
    prototype.set_strand = function(value) {
  if (this.strand_ !== value) {
    this.strand_ = value;
    value.element.type = 'password';
  }
};