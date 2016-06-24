#import "Reference.i"

namespace pafcore
{
	enum Category
	{
		void_object,
		primitive_object,
		enum_object,
		value_object,
		reference_object,
		enumerator,
		instance_field,
		static_field,
		instance_property,
		static_property,
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

	abstract class $PAFCORE_EXPORT Metadata : Reference
	{
		const char* _name_ get;
		Category _category_ get;
		Metadata* _scope_ get;
		$*
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
	public:
		Metadata(const char* name);
		bool operator < (const Metadata& arg) const;
	public:
		const char* m_name;
		Metadata* m_scope;
		*$
	};

	$*

	inline const char* Metadata::get__name_()
	{
		return m_name;
	}

	inline Metadata* Metadata::get__scope_()
	{
		return m_scope;
	}

	class CompareMetaDataPtrByName
	{
	public:
		bool operator()(const Metadata* m1, const Metadata* m2);
	};

	*$

}