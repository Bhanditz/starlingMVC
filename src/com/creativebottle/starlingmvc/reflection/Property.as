/*
 * Copyright 2012 StarlingMVC Framework Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.creativebottle.starlingmvc.reflection
{
	/**
	 * Class for properties within a meta class
	 */
	public class Property extends ClassMember
	{
		/**
		 * Constructor
		 *
		 * @param xml The xml representation of the meta property
		 */
		public function Property(xml:XML)
		{
			super(xml);
		}

		/**
		 * Returns a string representation of the meta property
		 */
		public function toString():String
		{
			return "Property{ name:" + name + ",classname:" + classname + ",tags:" + tags + " }";
		}
	}
}