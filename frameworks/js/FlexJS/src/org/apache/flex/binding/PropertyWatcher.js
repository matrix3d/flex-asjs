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

goog.provide('org.apache.flex.binding.PropertyWatcher');
goog.require('org.apache.flex.binding.WatcherBase');

/**
 * @constructor
 * @param {Object} source The source object.
 * @param {string} propertyName The property in the source.
 * @param {Object} eventNames An array of event names or an event name.
 * @param {function} getterFunction A function to get the source property.
 */
org.apache.flex.binding.PropertyWatcher =
        function(source, propertyName, eventNames, getterFunction) {
    this.source = source;
    this.propertyName = propertyName;
    this.getterFunction = getterFunction;
    this.eventNames = eventNames;
};
goog.inherits(org.apache.flex.binding.PropertyWatcher,
    org.apache.flex.binding.WatcherBase);


/**
 * @type {Object}
 */
org.apache.flex.binding.PropertyWatcher.prototype.source;

/**
 * @type {string}
 */
org.apache.flex.binding.PropertyWatcher.prototype.propertyName;

/**
 * @type {Object}
 */
org.apache.flex.binding.PropertyWatcher.prototype.eventNames;

/**
 * @type {function}
 */
org.apache.flex.binding.PropertyWatcher.prototype.getterFunction = null;

/**
 * @protected
 * @this {org.apache.flex.binding.PropertyWatcher}
 * @param {Object} event The event.
 */
org.apache.flex.binding.PropertyWatcher.prototype.changeHandler =
        function(event) {
    if (typeof(event.propertyName) == 'string')
    {
        var propName = event.propertyName;

        if (propName != this.propertyName)
            return;
    }

    this.wrapUpdate(this.updateProperty);

    this.notifyListeners();

};

/**
 * @protected
 * @this {org.apache.flex.binding.PropertyWatcher}
 * @param {Object} parent The new parent watcher.
 */
org.apache.flex.binding.PropertyWatcher.prototype.parentChanged =
        function(parent) {

    if (this.source &&
        typeof(this.source.removeEventListener) == 'function')
        this.removeEventListeners();

    this.source = parent;

    if (this.source)
        this.addEventListeners();

    // Now get our property.
    this.wrapUpdate(this.updateProperty);
};

/**
 * @protected
 * @this {org.apache.flex.binding.PropertyWatcher}
 */
org.apache.flex.binding.PropertyWatcher.prototype.addEventListeners =
        function() {
    if (typeof(this.eventNames) == 'string')
        this.source.addEventListener(this.eventNames,
            goog.bind(this.changeHandler, this));
    else if (typeof(this.eventNames) == 'Object')
    {
        var arr = this.eventNames;
        var n = arr.length;
        for (var i = 0; i < n; i++)
        {
            var eventName = this.eventNames[i];
            this.source.addEventListener(eventName,
                goog.bind(this.changeHandler, this));
        }
    }
};

/**
 * @protected
 * @this {org.apache.flex.binding.PropertyWatcher}
 */
org.apache.flex.binding.PropertyWatcher.prototype.removeEventListeners =
        function() {
    if (typeof(this.eventNames) == 'string')
        this.source.removeEventListener(this.eventNames,
                goog.bind(this.changeHandler, this));
    else if (typeof(this.eventNames) == 'Object')
    {
        var arr = this.eventNames;
        var n = arr.length;
        for (var i = 0; i < n; i++)
        {
            var eventName = this.eventNames[i];
            this.source.removeEventListener(eventName,
                goog.bind(this.changeHandler, this));
        }
    }
};

/**
 * @protected
 * Gets the actual property then updates
 * the Watcher's children appropriately.
 * @this {org.apache.flex.binding.PropertyWatcher}
 */
org.apache.flex.binding.PropertyWatcher.prototype.updateProperty =
        function() {

    if (this.source)
    {
        if (this.propertyName == 'this')
        {
            this.value = this.source;
        }
        else
        {
            if (this.getterFunction != null)
            {
                this.value = this.getterFunction.apply(
                        this.source, [this.propertyName]);
            }
            else
            {
                this.value = this.source[this.propertyName];
            }
        }
    }
    else
    {
        this.value = null;
    }

    this.updateChildren();
};