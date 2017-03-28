#import "Reference.i"

namespace pafcore
{
#{
	struct Attribute
	{
		const char* name;
		const char* content;
	};
	struct Attributes
	{
		size_t count;
		Attribute* attributes;
	};
#}
	enum Category
	{
		void_object,
		primitive_object,
		enum_object,
		value_object,
		reference_object,
##		atomic_reference_object = reference_object,
		enumerator,
		instance_field,
		static_field,
		instance_property,
		static_property,
		instance_array_property,
		static_array_property,
		instance_method,
		static_method,
		function_argument,
		function_result,
		void_type,
		primitive_type,
		enum_type,
		class_type,
		type_alias,
		name_space,
	};

	abstract class #PAFCORE_EXPORT Metadata : Reference
	{
		const char* _name_ get;
		Category _category_ get;
		size_t _attributeCount_ get;
		const char* _getAttributeName_(size_t index);
		const char* _getAttributeContent_(size_t index);
		const char* _getAttributeContentByName_(const char* attributeName);
#{
	public:
		enum Passing
		{
			by_value,
			by_ref,
			by_ptr,
			by_out_ptr,
			by_out_ref,
			by_new,
			by_new_array,
			by_new_ptr,
			by_new_ref,
			by_new_array_ptr,
			by_new_array_ref,
		};
		enum TypeCompound
		{
			tc_none,
			tc_pointer,
			tc_array,
		};
	public:
		Metadata(const char* name, Attributes* attributes = 0);
		bool operator < (const Metadata& arg) const;
	public:
		const char* m_name;
		Attributes* m_attributes;
#}
	};

#{

	inline size_t Metadata::get__attributeCount_() const
	{
		return m_attributes ? m_attributes->count : 0;
	}

	inline const char* Metadata::get__name_() const
	{
		return m_name;
	}

	class CompareMetaDataPtrByName
	{
	public:
		bool operator()(const Metadata* m1, const Metadata* m2);
	};

#}

}