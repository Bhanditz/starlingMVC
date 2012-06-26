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
package com.creativebottle.starlingmvc.beans
{
	import com.creativebottle.starlingmvc.utils.MetaClassCache;
	import com.creativebottle.system.injection.InjectionTag;
	import com.creativebottle.system.meta.MetaClass;
	import com.creativebottle.system.meta.MetaClassMember;

	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class Beans
	{
		public const beans:Dictionary = new Dictionary(true);

		public function addBean(beanIn:*):void
		{
			var bean:Bean = normalizeBean(beanIn);

			if (bean is Prototype)
			{
				createMap(Prototype(bean).classType, bean);
			}
			else
			{
				var className:String = getQualifiedClassName(bean.instance);
				var myClass:Class = getDefinitionByName(className) as Class;

				createMap(myClass, bean);
			}
		}

		public function removeBean(beanIn:Bean):void
		{
			var bean:Bean;

			for each(bean in beans)
			{
				if (!bean.instance) continue;

				var metaClass:MetaClass = MetaClassCache.getMetaClassForInstance(bean.instance);

				var injections:Array = metaClass.membersByMetaTag(InjectionTag.INJECT);

				for each(var member:MetaClassMember in injections)
				{
					if (bean.instance[member.name] == beanIn.instance)
						bean.instance[member.name] = null;
				}
			}

			for (var key:Object in beans)
			{
				bean = beans[key];

				if (bean.instance == beanIn.instance)
				{
					beans[key] = null;
					delete beans[key];
				}
			}
		}

		public function addBeans(beanProviders:Array):void
		{
			for each(var provider:Object in beanProviders)
			{
				if (provider is BeanProvider)
				{
					addBeanProvider(provider as BeanProvider);
				}
				else
				{
					addBean(provider);
				}
			}

		}

		public function addBeanProvider(beanProviders:BeanProvider):void
		{
			for each(var bean:Object in beanProviders.beans)
			{
				addBean(bean);
			}
		}

		private function createMap(MapClass:Class, bean:Bean):void
		{
			if (bean.id)
			{
				beans[bean.id] = bean;
			}
			else
			{
				beans[MapClass] = bean;
			}
		}

		public function getBeanByClass(BeanClass:Class):Bean
		{
			return beans[BeanClass];
		}

		public function getBeanById(id:String):Bean
		{
			return beans[id];
		}

		private function normalizeBean(bean:Object):Bean
		{
			if (bean is Bean)
			{
				return bean as Bean;
			}
			else
			{
				return new Bean(bean);
			}
		}
	}
}