#import "Type.i"
#import "InstanceProperty.i"
#import "InstanceArrayProperty.i"

namespace pafcore
{
#{
	class InstanceField;
	class InstanceProperty;
	class InstanceArrayProperty;
	class InstanceMethod;
	class StaticField;
	class StaticProperty;
	class StaticArrayProperty;
	class StaticMethod;
	class Enumerator;
	class TypeAlias;
	class SubclassInvoker;
#}
	abstract struct #PAFCORE_EXPORT ClassTypeIterator
	{
		nocode ClassTypeIterator* next();
		nocode ClassType* deref();
#{
	public:
		ClassTypeIterator(ClassTypeIterator* iterator, ClassType* classType)
		{
			m_next = iterator;
			m_classType = classType;
		}
		ClassTypeIterator* next()
		{
			return m_next;
		}
		ClassType* deref()
		{
			return m_classType;
		}
	public:
		ClassTypeIterator* m_next;
		ClassType* m_classType;
#}
	};

	abstract class(class_type)#PAFCORE_EXPORT ClassType : Type
	{
		size_t _getMemberCount_(bool includeBaseClasses);
		Metadata* _getMember_(size_t index, bool includeBaseClasses);
		Metadata* _findMember_(const char* name, bool includeBaseClasses);
		size_t _getBaseClassCount_();
		Metadata* _getBaseClass_(size_t index);
		ClassTypeIterator* _getFirstDerivedClass_();

		size_t _getInstancePropertyCount_(bool includeBaseClasses);
		InstanceProperty* _getInstanceProperty_(size_t index, bool includeBaseClasses);
		size_t _getInstanceArrayPropertyCount_(bool includeBaseClasses);
		InstanceArrayProperty* _getInstanceArrayProperty_(size_t index, bool includeBaseClasses);
#{
	public:
		struct BaseClass
		{
			ClassType* m_type;
			ptrdiff_t m_offset;
		};
	public:
		ClassType(const char* name, Category category);
	public:
		virtual Metadata* findMember(const char* name);
		virtual void* createSubclassProxy(SubclassInvoker* subclassInvoker);
		virtual void destroySubclassProxy(void* subclassProxy);
		Metadata* findMember(const char* name, bool includeBaseClasses);
		Metadata* findClassMember(const char* name, bool includeBaseClasses);
	public:
		bool isType(ClassType* otherType);
		bool getClassOffset_(size_t& offset, ClassType* otherType);
		bool getClassOffset(size_t& offset, ClassType* otherType);
		Type* findNestedType(const char* name, bool includeBaseClasses);
		TypeAlias* findNestedTypeAlias(const char* name, bool includeBaseClasses);
		InstanceField* findInstanceField(const char* name, bool includeBaseClasses);
		StaticField* findStaticField(const char* name, bool includeBaseClasses);
		InstanceProperty* findInstanceProperty(const char* name, bool includeBaseClasses);
		InstanceArrayProperty* findInstanceArrayProperty(const char* name, bool includeBaseClasses);
		StaticProperty* findStaticProperty(const char* name, bool includeBaseClasses);
		StaticArrayProperty* findStaticArrayProperty(const char* name, bool includeBaseClasses);
		InstanceMethod* findInstanceMethod(const char* name, bool includeBaseClasses);
		StaticMethod* findStaticMethod(const char* name, bool includeBaseClasses);

	public:
		BaseClass* m_baseClasses;
		size_t m_baseClassCount;
		ClassTypeIterator* m_classTypeIterators;
		ClassTypeIterator* m_firstDerivedClass;
		Metadata** m_members;
		size_t m_memberCount;
		Type** m_nestedTypes;
		size_t m_nestedTypeCount;
		TypeAlias** m_nestedTypeAliases;
		size_t m_nestedTypeAliasCount;
		InstanceField* m_instanceFields;
		size_t m_instanceFieldCount;
		InstanceProperty* m_instanceProperties;
		size_t m_instancePropertyCount;
		InstanceArrayProperty* m_instanceArrayProperties;
		size_t m_instanceArrayPropertyCount;
		InstanceMethod* m_instanceMethods;
		size_t m_instanceMethodCount;
		StaticField* m_staticFields;
		size_t m_staticFieldCount;
		StaticProperty* m_staticProperties;
		size_t m_staticPropertyCount;
		StaticArrayProperty* m_staticArrayProperties;
		size_t m_staticArrayPropertyCount;
		StaticMethod* m_staticMethods;
		size_t m_staticMethodCount;
#}
	};
}
