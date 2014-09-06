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
 *
 * org.apache.flex.charts.core.IChartSeries
 *
 * @fileoverview
 *
 * @suppress {checkTypes}
 */

goog.provide('org.apache.flex.charts.core.IChartSeries');

goog.require('mx.core.IFactory');



/**
 * @interface
 */
org.apache.flex.charts.core.IChartSeries = function() {
};


/**
 * @return {string}
 */
org.apache.flex.charts.core.IChartSeries.prototype.get_xField = function() {};


/**
 * @param {string} value
 */
org.apache.flex.charts.core.IChartSeries.prototype.set_xField = function(value) {};


/**
 * @return {string}
 */
org.apache.flex.charts.core.IChartSeries.prototype.get_yField = function() {};


/**
 * @param {string} value
 */
org.apache.flex.charts.core.IChartSeries.prototype.set_yField = function(value) {};


/**
 * @return {number}
 */
org.apache.flex.charts.core.IChartSeries.prototype.get_fillColor = function() {};


/**
 * @param {number} value
 */
org.apache.flex.charts.core.IChartSeries.prototype.set_fillColor = function(value) {};


/**
 * @return {mx.core.IFactory}
 */
org.apache.flex.charts.core.IChartSeries.prototype.get_itemRenderer = function() {};


/**
 * @param {mx.core.IFactory} value
 */
org.apache.flex.charts.core.IChartSeries.prototype.set_itemRenderer = function(value) {};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.charts.core.IChartSeries.prototype.FLEXJS_CLASS_INFO = {
    names: [{ name: 'IChartSeries', qName: 'org.apache.flex.charts.core.IChartSeries'}]
  };