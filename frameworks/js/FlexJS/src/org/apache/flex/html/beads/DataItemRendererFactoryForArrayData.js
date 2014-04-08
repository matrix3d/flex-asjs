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

goog.provide('org.apache.flex.html.beads.DataItemRendererFactoryForArrayData');

goog.require('org.apache.flex.core.IDataProviderItemRendererMapper');
goog.require('org.apache.flex.events.EventDispatcher');
goog.require('org.apache.flex.html.beads.ListView');
goog.require('org.apache.flex.html.beads.models.ArraySelectionModel');
goog.require('org.apache.flex.html.supportClasses.ButtonBarButtonItemRenderer');



/**
 * @constructor
 * @implements {org.apache.flex.core.IDataProviderItemRendererMapper}
 */
org.apache.flex.html.beads.DataItemRendererFactoryForArrayData =
    function() {
};


/**
 * @expose
 */
org.apache.flex.html.beads.DataItemRendererFactoryForArrayData.prototype.itemRendererFactory = null;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.html.beads.DataItemRendererFactoryForArrayData.
    prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'DataItemRendererFactoryForArrayData',
                qName: 'org.apache.flex.html.beads.DataItemRendererFactoryForArrayData' }],
      interfaces: [org.apache.flex.core.IDataProviderItemRendererMapper] };


/**
 * @private
 * @type {Object}
 */
org.apache.flex.html.beads.DataItemRendererFactoryForArrayData.
    prototype.itemRendererClass_ = null;


/**
 * @expose
 * @param {Object} value The component strand.
 */
org.apache.flex.html.beads.DataItemRendererFactoryForArrayData.
    prototype.set_strand = function(value) {
  this.strand_ = value;

  this.model = value.getBeadByType(
      org.apache.flex.html.beads.models.ArraySelectionModel);

  this.listView = value.getBeadByType(
      org.apache.flex.html.beads.ListView);
  this.dataGroup = this.listView.get_dataGroup();

  this.model.addEventListener('dataProviderChanged',
      goog.bind(this.dataProviderChangedHandler, this));

  if (org.apache.flex.core.ValuesManager.valuesImpl.getValue && !this.itemRendererFactory_) {
    /**
     * @type {Function}
     */
    var c = /** @type {Function} */ (org.apache.flex.core.ValuesManager.valuesImpl.getValue(this.strand_,
            'iItemRendererClassFactory'));
    this.itemRendererFactory_ = new c();
    this.strand_.addBead(this.itemRendererFactory_);
  }

  this.dataProviderChangedHandler(null);
};


/**
 * @expose
 * @return {Object} The itemRenderer.
 */
org.apache.flex.html.beads.DataItemRendererFactoryForArrayData.
    prototype.get_itemRendererClass = function() {
  if (org.apache.flex.core.ValuesManager.valuesImpl.getValue && !this.itemRendererClass_) {
    var c = org.apache.flex.core.ValuesManager.valuesImpl.getValue(this.strand_, 'iItemRenderer');
    if (c) {
      this.itemRendererClass_ = c;
    }
  }
  return this.itemRendererClass_;
};


/**
 * @expose
 * @param {Object} value class to use for the item renderer.
 */
org.apache.flex.html.beads.DataItemRendererFactoryForArrayData.
    prototype.set_itemRendererClass = function(value) {
  this.itemRendererClass_ = value;
};


/**
 * @expose
 * @param {Object} event The event that triggered the dataProvider change.
 */
org.apache.flex.html.beads.DataItemRendererFactoryForArrayData.
    prototype.dataProviderChangedHandler = function(event) {
  var dp, i, n, opt;

  dp = this.model.get_dataProvider();
  n = dp.length;
  for (i = 0; i < n; i++) {
    var ir = this.itemRendererFactory_.createItemRenderer(this.dataGroup);
    ir.set_index(i);
    ir.set_labelField(this.model.get_labelField());
    ir.set_data(dp[i]);
  }

  var newEvent = new org.apache.flex.events.Event('itemsCreated');
  this.strand_.dispatchEvent(newEvent);
};