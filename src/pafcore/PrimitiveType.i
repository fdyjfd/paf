#import "Type.i"

$*
#include "Variant.h"
#include "Argument.h"
#include "Result.h"
#include "InstanceMethod.h"
#include "StaticMethod.h"
#include "NameSpace.h"
#include <algorithm>

#pragma warning( push )
#pragma warning( disable : 4804 )
#pragma warning( disable : 4800 )
#pragma warning( disable : 4146 )
*$

namespace pafcore
{
	$*
	enum PrimitiveTypeCategory
	{
		bool_type,
		char_type,
		signed_char_type,
		unsigned_char_type,
		wchar_type,
		short_type,
		unsigned_short_type,
		int_type,
		unsigned_int_type,
		long_type,
		unsigned_long_type,
		long_long_type,
		unsigned_long_long_type,
		float_type,
		double_type,
		long_double_type,
		primitive_type_count,
	};	
	*$

	abstract class(primitive_type)$PAFCORE_EXPORT PrimitiveType : Type
	{
		size_t _getMemberCount_();
		Metadata* _getMember_(size_t index);
		Metadata* _findMember_(const char* name);
		$*
	public:
		PrimitiveType(const char* name) : Type(name, primitive_object)
		{}
	public:
		InstanceMethod* findInstanceMethod(const char* name);
		StaticMethod* findStaticMethod(const char* name);
		Metadata* findTypeMember(const char* name);
		virtual Metadata* findMember(const char* name);
		virtual bool castTo(void* dst, Type* dstType, const void* src) = 0;
		//dst = +arg
		virtual void op_plus(void* dst, const void* arg) = 0;
		//dst = -arg
		virtual void op_negate(void* dst, const void* arg) = 0;
		//dst = ++arg
		virtual void op_increment(void* dst, void* arg) = 0;
		//dst = arg++
		virtual void op_postIncrement(void* dst, void* arg) = 0;
		//dst = --arg
		virtual void op_decrement(void* dst, void* arg) = 0;
		//dst = arg--
		virtual void op_postDecrement(void* dst, void* arg) = 0;
		//!arg1
		virtual bool op_not(const void* arg) = 0;
		//dst = ~arg
		virtual void op_bitwiseNot(void* dst, const void* arg) = 0;
		//dst = arg1 + arg2
		virtual void op_add(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 - arg2
		virtual void op_subtract(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 * arg2
		virtual void op_multiply(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 / arg2
		virtual void op_divide(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 % arg2
		virtual void op_mod(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 & arg2
		virtual void op_bitwiseAnd(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 | arg2
		virtual void op_bitwiseOr(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 ^ arg2
		virtual void op_bitwiseXor(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 << arg2
		virtual void op_leftShift(void* dst, const void* arg1, const void* arg2) = 0;
		//dst = arg1 >> arg2
		virtual void op_rightShift(void* dst, const void* arg1, const void* arg2) = 0;
		//arg1 < arg2
		virtual bool op_less(const void* arg1, const void* arg2) = 0;
		//arg1 <= arg2
		virtual bool op_lessEqual(const void* arg1, const void* arg2) = 0;
		//arg1 == arg2
		virtual bool op_equal(const void* arg1, const void* arg2) = 0;
		//arg1 != arg2
		virtual bool op_notEqual(const void* arg1, const void* arg2) = 0;
		//arg1 >= arg2
		virtual bool op_greaterEqual(const void* arg1, const void* arg2) = 0;
		//arg1 > arg2
		virtual bool op_greater(const void* arg1, const void* arg2) = 0;
	public:
		//unary
		static ErrorCode Primitive_op_plus(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_negate(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_increment(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_postIncrement(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_decrement(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_postDecrement(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_not(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_bitwiseNot(Variant* result, Variant** args, int_t numArgs);

		//binary
		static ErrorCode Primitive_op_add(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_subtract(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_multiply(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_divide(Variant* result, Variant** args, int_t numArgs);
		//integer only
		static ErrorCode Primitive_op_mod(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_bitwiseAnd(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_bitwiseOr(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_bitwiseXor(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_leftShift(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_rightShift(Variant* result, Variant** args, int_t numArgs);

		//compare
		static ErrorCode Primitive_op_less(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_lessEqual(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_equal(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_notEqual(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_greaterEqual(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_greater(Variant* result, Variant** args, int_t numArgs);

		//assign
		static ErrorCode Primitive_op_assign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_addAssign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_subtractAssign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_multiplyAssign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_divideAssign(Variant* result, Variant** args, int_t numArgs);
		//integer only
		static ErrorCode Primitive_op_modAssign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_bitwiseXorAssign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_bitwiseAndAssign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_bitwiseOrAssign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_leftShiftAssign(Variant* result, Variant** args, int_t numArgs);
		static ErrorCode Primitive_op_rightShiftAssign(Variant* result, Variant** args, int_t numArgs);
	public:
		PrimitiveTypeCategory m_typeCategory;
		Metadata** m_members;
		size_t m_memberCount;
		InstanceMethod* m_methods;
		size_t m_methodCount;
		StaticMethod* m_staticMethods;
		size_t m_staticMethodCount;
		*$
	};

	$*
	template<typename T>
	struct PAFCORE_EXPORT PrimitiveTypeTraits
	{
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<bool>
	{
		enum { type_category = bool_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<char>
	{
		enum { type_category = char_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<unsigned char>
	{
		enum { type_category = unsigned_char_type };
		static const char* s_typeName;;
	};


	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<signed char>
	{
		enum { type_category = signed_char_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<wchar_t>
	{
		enum { type_category = wchar_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<short>
	{
		enum { type_category = short_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<unsigned short>
	{
		enum { type_category = unsigned_short_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<int>
	{
		enum { type_category = int_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<unsigned int>
	{
		enum { type_category = unsigned_int_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<long>
	{
		enum { type_category = long_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<unsigned long>
	{
		enum { type_category = unsigned_long_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<long long>
	{
		enum { type_category = long_long_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<unsigned long long>
	{
		enum { type_category = unsigned_long_long_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<float>
	{
		enum { type_category = float_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<double>
	{
		enum { type_category = double_type };
		static const char* s_typeName;;
	};

	template<>
	struct PAFCORE_EXPORT PrimitiveTypeTraits<long double>
	{
		enum { type_category = long_double_type };
		static const char* s_typeName;;
	};


	template<typename T>
	class PAFCORE_EXPORT PrimitiveTypeImpl : public PrimitiveType
	{
	public:
		PrimitiveTypeImpl(const char* name) : PrimitiveType(name)
		{
			m_typeCategory = (PrimitiveTypeCategory)PrimitiveTypeTraits<T>::type_category;
			m_name = name;
			m_size = sizeof(T);

			static ::pafcore::Result s_New_Result_0(this, false, ::pafcore::Result::by_new);
			static ::pafcore::Result s_New_Result_1(this, false, ::pafcore::Result::by_new);
			static ::pafcore::Argument s_New_Arguments_1[] =
			{
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_ref, true),
			};
			static ::pafcore::Result s_NewArray_Result_2(this, false, ::pafcore::Result::by_new_array);
			static ::pafcore::Argument s_NewArray_Arguments_2[] =
			{
				::pafcore::Argument("count", RuntimeTypeOf<unsigned int>::RuntimeType::GetSingleton(), ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Overload s_New_Overloads[] =
			{
				::pafcore::Overload(&s_New_Result_0, 0, 0),
				::pafcore::Overload(&s_New_Result_1, s_New_Arguments_1, 1),
			};
			static ::pafcore::Overload s_NewArray_Overloads[] =
			{
				::pafcore::Overload(&s_NewArray_Result_2, s_NewArray_Arguments_2, 1),
			};
			static ::pafcore::StaticMethod s_staticMethods[] =
			{
				::pafcore::StaticMethod("New", Primitive_New, s_New_Overloads, 2),
				::pafcore::StaticMethod("NewArray", Primitive_NewArray, s_NewArray_Overloads, 1),
			};
			m_staticMethods = s_staticMethods;
			m_staticMethodCount = paf_array_size_of(s_staticMethods);
			static ::pafcore::Result s_op_add_Result_0(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_add_Arguments_0[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_addAssign_Result_1(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_addAssign_Arguments_1[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_assign_Result_2(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_assign_Arguments_2[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_bitwiseAnd_Result_3(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_bitwiseAnd_Arguments_3[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_bitwiseAndAssign_Result_4(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_bitwiseAndAssign_Arguments_4[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_bitwiseNot_Result_5(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_bitwiseNot_Arguments_5[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
			};
			static ::pafcore::Result s_op_bitwiseOr_Result_6(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_bitwiseOr_Arguments_6[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_bitwiseOrAssign_Result_7(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_bitwiseOrAssign_Arguments_7[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_bitwiseXor_Result_8(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_bitwiseXor_Arguments_8[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_bitwiseXorAssign_Result_9(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_bitwiseXorAssign_Arguments_9[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_decrement_Result_10(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_decrement_Arguments_10[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
			};
			static ::pafcore::Result s_op_divide_Result_11(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_divide_Arguments_11[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_divideAssign_Result_12(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_divideAssign_Arguments_12[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_equal_Result_13(RuntimeTypeOf<bool>::RuntimeType::GetSingleton(), false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_equal_Arguments_13[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_greater_Result_14(RuntimeTypeOf<bool>::RuntimeType::GetSingleton(), false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_greater_Arguments_14[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_greaterEqual_Result_15(RuntimeTypeOf<bool>::RuntimeType::GetSingleton(), false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_greaterEqual_Arguments_15[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_increment_Result_16(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_increment_Arguments_16[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
			};
			static ::pafcore::Result s_op_leftShift_Result_17(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_leftShift_Arguments_17[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_leftShiftAssign_Result_18(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_leftShiftAssign_Arguments_18[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_less_Result_19(RuntimeTypeOf<bool>::RuntimeType::GetSingleton(), false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_less_Arguments_19[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_lessEqual_Result_20(RuntimeTypeOf<bool>::RuntimeType::GetSingleton(), false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_lessEqual_Arguments_20[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_mod_Result_21(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_mod_Arguments_21[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_modAssign_Result_22(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_modAssign_Arguments_22[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_multiply_Result_23(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_multiply_Arguments_23[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_multiplyAssign_Result_24(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_multiplyAssign_Arguments_24[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_negate_Result_25(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_negate_Arguments_25[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
			};
			static ::pafcore::Result s_op_not_Result_26(RuntimeTypeOf<bool>::RuntimeType::GetSingleton(), false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_not_Arguments_26[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
			};
			static ::pafcore::Result s_op_notEqual_Result_27(RuntimeTypeOf<bool>::RuntimeType::GetSingleton(), false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_notEqual_Arguments_27[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_plus_Result_28(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_plus_Arguments_28[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
			};
			static ::pafcore::Result s_op_postDecrement_Result_29(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_postDecrement_Arguments_29[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
			};
			static ::pafcore::Result s_op_postIncrement_Result_30(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_postIncrement_Arguments_30[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
			};
			static ::pafcore::Result s_op_rightShift_Result_31(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_rightShift_Arguments_31[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_rightShiftAssign_Result_32(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_rightShiftAssign_Arguments_32[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_subtract_Result_33(this, false, ::pafcore::Result::by_value);
			static ::pafcore::Argument s_op_subtract_Arguments_33[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Result s_op_subtractAssign_Result_34(this, false, ::pafcore::Result::by_ref);
			static ::pafcore::Argument s_op_subtractAssign_Arguments_34[] =
			{
				::pafcore::Argument("this", this, ::pafcore::Argument::by_ptr, false),
				::pafcore::Argument("arg", this, ::pafcore::Argument::by_value, false),
			};
			static ::pafcore::Overload s_op_add_Overloads[] =
			{
				::pafcore::Overload(&s_op_add_Result_0, s_op_add_Arguments_0, 1),
			};
			static ::pafcore::Overload s_op_addAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_addAssign_Result_1, s_op_addAssign_Arguments_1, 1),
			};
			static ::pafcore::Overload s_op_assign_Overloads[] =
			{
				::pafcore::Overload(&s_op_assign_Result_2, s_op_assign_Arguments_2, 1),
			};
			static ::pafcore::Overload s_op_bitwiseAnd_Overloads[] =
			{
				::pafcore::Overload(&s_op_bitwiseAnd_Result_3, s_op_bitwiseAnd_Arguments_3, 1),
			};
			static ::pafcore::Overload s_op_bitwiseAndAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_bitwiseAndAssign_Result_4, s_op_bitwiseAndAssign_Arguments_4, 1),
			};
			static ::pafcore::Overload s_op_bitwiseNot_Overloads[] =
			{
				::pafcore::Overload(&s_op_bitwiseNot_Result_5, 0, 0),
			};
			static ::pafcore::Overload s_op_bitwiseOr_Overloads[] =
			{
				::pafcore::Overload(&s_op_bitwiseOr_Result_6, s_op_bitwiseOr_Arguments_6, 1),
			};
			static ::pafcore::Overload s_op_bitwiseOrAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_bitwiseOrAssign_Result_7, s_op_bitwiseOrAssign_Arguments_7, 1),
			};
			static ::pafcore::Overload s_op_bitwiseXor_Overloads[] =
			{
				::pafcore::Overload(&s_op_bitwiseXor_Result_8, s_op_bitwiseXor_Arguments_8, 1),
			};
			static ::pafcore::Overload s_op_bitwiseXorAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_bitwiseXorAssign_Result_9, s_op_bitwiseXorAssign_Arguments_9, 1),
			};
			static ::pafcore::Overload s_op_decrement_Overloads[] =
			{
				::pafcore::Overload(&s_op_decrement_Result_10, 0, 0),
			};
			static ::pafcore::Overload s_op_divide_Overloads[] =
			{
				::pafcore::Overload(&s_op_divide_Result_11, s_op_divide_Arguments_11, 1),
			};
			static ::pafcore::Overload s_op_divideAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_divideAssign_Result_12, s_op_divideAssign_Arguments_12, 1),
			};
			static ::pafcore::Overload s_op_equal_Overloads[] =
			{
				::pafcore::Overload(&s_op_equal_Result_13, s_op_equal_Arguments_13, 1),
			};
			static ::pafcore::Overload s_op_greater_Overloads[] =
			{
				::pafcore::Overload(&s_op_greater_Result_14, s_op_greater_Arguments_14, 1),
			};
			static ::pafcore::Overload s_op_greaterEqual_Overloads[] =
			{
				::pafcore::Overload(&s_op_greaterEqual_Result_15, s_op_greaterEqual_Arguments_15, 1),
			};
			static ::pafcore::Overload s_op_increment_Overloads[] =
			{
				::pafcore::Overload(&s_op_increment_Result_16, 0, 0),
			};
			static ::pafcore::Overload s_op_leftShift_Overloads[] =
			{
				::pafcore::Overload(&s_op_leftShift_Result_17, s_op_leftShift_Arguments_17, 1),
			};
			static ::pafcore::Overload s_op_leftShiftAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_leftShiftAssign_Result_18, s_op_leftShiftAssign_Arguments_18, 1),
			};
			static ::pafcore::Overload s_op_less_Overloads[] =
			{
				::pafcore::Overload(&s_op_less_Result_19, s_op_less_Arguments_19, 1),
			};
			static ::pafcore::Overload s_op_lessEqual_Overloads[] =
			{
				::pafcore::Overload(&s_op_lessEqual_Result_20, s_op_lessEqual_Arguments_20, 1),
			};
			static ::pafcore::Overload s_op_mod_Overloads[] =
			{
				::pafcore::Overload(&s_op_mod_Result_21, s_op_mod_Arguments_21, 1),
			};
			static ::pafcore::Overload s_op_modAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_modAssign_Result_22, s_op_modAssign_Arguments_22, 1),
			};
			static ::pafcore::Overload s_op_multiply_Overloads[] =
			{
				::pafcore::Overload(&s_op_multiply_Result_23, s_op_multiply_Arguments_23, 1),
			};
			static ::pafcore::Overload s_op_multiplyAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_multiplyAssign_Result_24, s_op_multiplyAssign_Arguments_24, 1),
			};
			static ::pafcore::Overload s_op_negate_Overloads[] =
			{
				::pafcore::Overload(&s_op_negate_Result_25, 0, 0),
			};
			static ::pafcore::Overload s_op_not_Overloads[] =
			{
				::pafcore::Overload(&s_op_not_Result_26, 0, 0),
			};
			static ::pafcore::Overload s_op_notEqual_Overloads[] =
			{
				::pafcore::Overload(&s_op_notEqual_Result_27, s_op_notEqual_Arguments_27, 1),
			};
			static ::pafcore::Overload s_op_plus_Overloads[] =
			{
				::pafcore::Overload(&s_op_plus_Result_28, 0, 0),
			};
			static ::pafcore::Overload s_op_postDecrement_Overloads[] =
			{
				::pafcore::Overload(&s_op_postDecrement_Result_29, 0, 0),
			};
			static ::pafcore::Overload s_op_postIncrement_Overloads[] =
			{
				::pafcore::Overload(&s_op_postIncrement_Result_30, 0, 0),
			};
			static ::pafcore::Overload s_op_rightShift_Overloads[] =
			{
				::pafcore::Overload(&s_op_rightShift_Result_31, s_op_rightShift_Arguments_31, 1),
			};
			static ::pafcore::Overload s_op_rightShiftAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_rightShiftAssign_Result_32, s_op_rightShiftAssign_Arguments_32, 1),
			};
			static ::pafcore::Overload s_op_subtract_Overloads[] =
			{
				::pafcore::Overload(&s_op_subtract_Result_33, s_op_subtract_Arguments_33, 1),
			};
			static ::pafcore::Overload s_op_subtractAssign_Overloads[] =
			{
				::pafcore::Overload(&s_op_subtractAssign_Result_34, s_op_subtractAssign_Arguments_34, 1),
			};
			static ::pafcore::InstanceMethod s_methods[] =
			{
				::pafcore::InstanceMethod("op_add", Primitive_op_add, s_op_add_Overloads, 1),
				::pafcore::InstanceMethod("op_addAssign", Primitive_op_addAssign, s_op_addAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_assign", Primitive_op_assign, s_op_assign_Overloads, 1),
				::pafcore::InstanceMethod("op_bitwiseAnd", Primitive_op_bitwiseAnd, s_op_bitwiseAnd_Overloads, 1),
				::pafcore::InstanceMethod("op_bitwiseAndAssign", Primitive_op_bitwiseAndAssign, s_op_bitwiseAndAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_bitwiseNot", Primitive_op_bitwiseNot, s_op_bitwiseNot_Overloads, 1),
				::pafcore::InstanceMethod("op_bitwiseOr", Primitive_op_bitwiseOr, s_op_bitwiseOr_Overloads, 1),
				::pafcore::InstanceMethod("op_bitwiseOrAssign", Primitive_op_bitwiseOrAssign, s_op_bitwiseOrAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_bitwiseXor", Primitive_op_bitwiseXor, s_op_bitwiseXor_Overloads, 1),
				::pafcore::InstanceMethod("op_bitwiseXorAssign", Primitive_op_bitwiseXorAssign, s_op_bitwiseXorAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_decrement", Primitive_op_decrement, s_op_decrement_Overloads, 1),
				::pafcore::InstanceMethod("op_divide", Primitive_op_divide, s_op_divide_Overloads, 1),
				::pafcore::InstanceMethod("op_divideAssign", Primitive_op_divideAssign, s_op_divideAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_equal", Primitive_op_equal, s_op_equal_Overloads, 1),
				::pafcore::InstanceMethod("op_greater", Primitive_op_greater, s_op_greater_Overloads, 1),
				::pafcore::InstanceMethod("op_greaterEqual", Primitive_op_greaterEqual, s_op_greaterEqual_Overloads, 1),
				::pafcore::InstanceMethod("op_increment", Primitive_op_increment, s_op_increment_Overloads, 1),
				::pafcore::InstanceMethod("op_leftShift", Primitive_op_leftShift, s_op_leftShift_Overloads, 1),
				::pafcore::InstanceMethod("op_leftShiftAssign", Primitive_op_leftShiftAssign, s_op_leftShiftAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_less", Primitive_op_less, s_op_less_Overloads, 1),
				::pafcore::InstanceMethod("op_lessEqual", Primitive_op_lessEqual, s_op_lessEqual_Overloads, 1),
				::pafcore::InstanceMethod("op_mod", Primitive_op_mod, s_op_mod_Overloads, 1),
				::pafcore::InstanceMethod("op_modAssign", Primitive_op_modAssign, s_op_modAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_multiply", Primitive_op_multiply, s_op_multiply_Overloads, 1),
				::pafcore::InstanceMethod("op_multiplyAssign", Primitive_op_multiplyAssign, s_op_multiplyAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_negate", Primitive_op_negate, s_op_negate_Overloads, 1),
				::pafcore::InstanceMethod("op_not", Primitive_op_not, s_op_not_Overloads, 1),
				::pafcore::InstanceMethod("op_notEqual", Primitive_op_notEqual, s_op_notEqual_Overloads, 1),
				::pafcore::InstanceMethod("op_plus", Primitive_op_plus, s_op_plus_Overloads, 1),
				::pafcore::InstanceMethod("op_postDecrement", Primitive_op_postDecrement, s_op_postDecrement_Overloads, 1),
				::pafcore::InstanceMethod("op_postIncrement", Primitive_op_postIncrement, s_op_postIncrement_Overloads, 1),
				::pafcore::InstanceMethod("op_rightShift", Primitive_op_rightShift, s_op_rightShift_Overloads, 1),
				::pafcore::InstanceMethod("op_rightShiftAssign", Primitive_op_rightShiftAssign, s_op_rightShiftAssign_Overloads, 1),
				::pafcore::InstanceMethod("op_subtract", Primitive_op_subtract, s_op_subtract_Overloads, 1),
				::pafcore::InstanceMethod("op_subtractAssign", Primitive_op_subtractAssign, s_op_subtractAssign_Overloads, 1),
			};
			m_methods = s_methods;
			m_methodCount = paf_array_size_of(s_methods);
			static Metadata* s_members[] =
			{
				&s_staticMethods[0],
				&s_staticMethods[1],
				&s_methods[0],
				&s_methods[1],
				&s_methods[2],
				&s_methods[3],
				&s_methods[4],
				&s_methods[5],
				&s_methods[6],
				&s_methods[7],
				&s_methods[8],
				&s_methods[9],
				&s_methods[10],
				&s_methods[11],
				&s_methods[12],
				&s_methods[13],
				&s_methods[14],
				&s_methods[15],
				&s_methods[16],
				&s_methods[17],
				&s_methods[18],
				&s_methods[19],
				&s_methods[20],
				&s_methods[21],
				&s_methods[22],
				&s_methods[23],
				&s_methods[24],
				&s_methods[25],
				&s_methods[26],
				&s_methods[27],
				&s_methods[28],
				&s_methods[29],
				&s_methods[30],
				&s_methods[31],
				&s_methods[32],
				&s_methods[33],
				&s_methods[34],
			};
			m_members = s_members;
			m_memberCount = paf_array_size_of(s_members);
			NameSpace::GetGlobalNameSpace()->registerMember(this);
		}
		static ErrorCode Primitive_New(Variant* result, Variant** args, int_t numArgs)
		{
			if(1 < numArgs)
			{
				return e_invalid_arg_num;
			}
			T a0 = 0;
			if(1 == numArgs)
			{
				if(!args[0]->castToPrimitive(RuntimeTypeOf<T>::RuntimeType::GetSingleton(), &a0))
				{
					return e_invalid_arg_type_1;
				}
			}
			result->assignPrimitive(RuntimeTypeOf<T>::RuntimeType::GetSingleton(), &a0);
			return s_ok;
		}
		static ErrorCode Primitive_NewArray(Variant* result, Variant** args, int_t numArgs)
		{
			if(1 == numArgs)
			{
				size_t count;
				if(!args[0]->castToPrimitive(RuntimeTypeOf<unsigned int>::RuntimeType::GetSingleton(), &count))
				{
					return e_invalid_arg_type_1;
				}
				T* p = paf_new_array<T>(count);
				result->assignArray(RuntimeTypeOf<T>::RuntimeType::GetSingleton(), p, count, false, Variant::by_new_array);
				return s_ok;
			}
			return e_invalid_arg_num;
		}
		virtual void destroyArray(void* address)
		{
			paf_delete_array((T*)address);
		}
		virtual bool castTo(void* dst, Type* dstType, const void* src)
		{
			if(!dstType->isPrimitive())
			{
				return false;
			}
			switch (static_cast<PrimitiveType*>(dstType)->m_typeCategory)
			{
			case bool_type:
				*reinterpret_cast<bool_t*>(dst) = *reinterpret_cast<const T*>(src) != 0;
				break;
			case char_type:
				*reinterpret_cast<char_t*>(dst) = static_cast<char_t>(*reinterpret_cast<const T*>(src));
				break;
			case signed_char_type:
				*reinterpret_cast<schar_t*>(dst) = static_cast<char_t>(*reinterpret_cast<const T*>(src));
				break;
			case unsigned_char_type:
				*reinterpret_cast<uchar_t*>(dst) = static_cast<uchar_t>(*reinterpret_cast<const T*>(src));
				break;
			case wchar_type:
				*reinterpret_cast<wchar_t*>(dst) = static_cast<wchar_t>(*reinterpret_cast<const T*>(src));
				break;
			case short_type:
				*reinterpret_cast<short_t*>(dst) = static_cast<short_t>(*reinterpret_cast<const T*>(src));
				break;
			case unsigned_short_type:
				*reinterpret_cast<ushort_t*>(dst) = static_cast<ushort_t>(*reinterpret_cast<const T*>(src));
				break;
			case int_type:
				*reinterpret_cast<int_t*>(dst) = static_cast<int_t>(*reinterpret_cast<const T*>(src));
				break;
			case unsigned_int_type:
				*reinterpret_cast<uint_t*>(dst) = static_cast<uint_t>(*reinterpret_cast<const T*>(src));
				break;
			case long_type:
				*reinterpret_cast<long_t*>(dst) = static_cast<long_t>(*reinterpret_cast<const T*>(src));
				break;
			case unsigned_long_type:
				*reinterpret_cast<ulong_t*>(dst) = static_cast<ulong_t>(*reinterpret_cast<const T*>(src));
				break;
			case long_long_type:
				*reinterpret_cast<longlong_t*>(dst) = static_cast<longlong_t>(*reinterpret_cast<const T*>(src));
				break;
			case unsigned_long_long_type:
				*reinterpret_cast<ulonglong_t*>(dst) = static_cast<ulonglong_t>(*reinterpret_cast<const T*>(src));
				break;
			case float_type:
				*reinterpret_cast<float_t*>(dst) = static_cast<float_t>(*reinterpret_cast<const T*>(src));
				break;
			case double_type:
				*reinterpret_cast<double_t*>(dst) = static_cast<double_t>(*reinterpret_cast<const T*>(src));
				break;
			case long_double_type:
				*reinterpret_cast<longdouble_t*>(dst) = static_cast<longdouble_t>(*reinterpret_cast<const T*>(src));
				break;
			default:
				return false;
			}
			return true;
		}
		virtual void op_plus(void* dst, const void* arg)
		{
			*reinterpret_cast<T*>(dst) = +*reinterpret_cast<const T*>(arg);
		}
		virtual bool op_not(const void* arg)
		{
			return !*reinterpret_cast<const T*>(arg);
		}
		virtual void op_add(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) + *reinterpret_cast<const T*>(arg2);
		}
		virtual void op_subtract(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) - *reinterpret_cast<const T*>(arg2);
		}
		virtual void op_multiply(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) * *reinterpret_cast<const T*>(arg2);
		}
		virtual void op_divide(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) / *reinterpret_cast<const T*>(arg2);
		}
		virtual bool op_less(const void* arg1, const void* arg2)
		{
			return *reinterpret_cast<const T*>(arg1) < *reinterpret_cast<const T*>(arg2);
		}
		virtual bool op_lessEqual(const void* arg1, const void* arg2)
		{
			return *reinterpret_cast<const T*>(arg1) <= *reinterpret_cast<const T*>(arg2);
		}
		virtual bool op_equal(const void* arg1, const void* arg2)
		{
			return *reinterpret_cast<const T*>(arg1) == *reinterpret_cast<const T*>(arg2);
		}
		virtual bool op_notEqual(const void* arg1, const void* arg2)
		{
			return *reinterpret_cast<const T*>(arg1) != *reinterpret_cast<const T*>(arg2);
		}
		virtual bool op_greaterEqual(const void* arg1, const void* arg2)
		{
			return *reinterpret_cast<const T*>(arg1) >= *reinterpret_cast<const T*>(arg2);
		}
		virtual bool op_greater(const void* arg1, const void* arg2)
		{
			return *reinterpret_cast<const T*>(arg1) > *reinterpret_cast<const T*>(arg2);
		}
	};
	
	template<typename T>
	class PAFCORE_EXPORT PrimitiveTypeImpl_Integer : public PrimitiveTypeImpl<T>
	{
	public:
		PrimitiveTypeImpl_Integer(const char* name) : PrimitiveTypeImpl(name)
		{}
		virtual void op_increment(void* dst, void* arg)
		{
			*reinterpret_cast<T*>(dst) = ++(*reinterpret_cast<T*>(arg));
		}
		virtual void op_postIncrement(void* dst, void* arg)
		{
			*reinterpret_cast<T*>(dst) = (*reinterpret_cast<T*>(arg))++;
		}
		virtual void op_bitwiseNot(void* dst, const void* arg)
		{
			*reinterpret_cast<T*>(dst) = ~*reinterpret_cast<const T*>(arg);
		}
		virtual void op_mod(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) % *reinterpret_cast<const T*>(arg2);
		}
		virtual void op_bitwiseAnd(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) & *reinterpret_cast<const T*>(arg2);
		}
		virtual void op_bitwiseOr(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) | *reinterpret_cast<const T*>(arg2);
		}
		virtual void op_bitwiseXor(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) ^ *reinterpret_cast<const T*>(arg2);
		}
		virtual void op_leftShift(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) << *reinterpret_cast<const char*>(arg2);
		}
		virtual void op_rightShift(void* dst, const void* arg1, const void* arg2)
		{
			*reinterpret_cast<T*>(dst) = *reinterpret_cast<const T*>(arg1) >> *reinterpret_cast<const char*>(arg2);
		}
	};

	template<typename T>
	class PAFCORE_EXPORT PrimitiveTypeImpl_Bool : public PrimitiveTypeImpl_Integer<T>
	{
	public:
		typedef PrimitiveTypeImpl_Bool<T> ThisType;
	public:
		PrimitiveTypeImpl_Bool(const char* name) : PrimitiveTypeImpl_Integer(name)
		{}
		static ThisType* GetSingleton()
		{
			static ThisType* s_instance = 0;
			static char s_buffer[sizeof(ThisType)];
			if (0 == s_instance)
			{
				s_instance = (ThisType*)s_buffer;
				new (s_buffer)ThisType(PrimitiveTypeTraits<T>::s_typeName);
			}
			return s_instance;
		}
		virtual void op_negate(void* dst, const void* arg)
		{
			*reinterpret_cast<T*>(dst) = -*reinterpret_cast<const T*>(arg);
		}
		virtual void op_decrement(void* dst, void* arg)
		{}
		virtual void op_postDecrement(void* dst, void* arg)
		{}
	};

	template<typename T>
	class PAFCORE_EXPORT PrimitiveTypeImpl_ForbidNegate : public PrimitiveTypeImpl_Integer<T>
	{
	public:
		typedef PrimitiveTypeImpl_ForbidNegate<T> ThisType;
	public:
		PrimitiveTypeImpl_ForbidNegate(const char* name) : PrimitiveTypeImpl_Integer(name)
		{}
		static ThisType* GetSingleton()
		{
			static ThisType* s_instance = 0;
			static char s_buffer[sizeof(ThisType)];
			if (0 == s_instance)
			{
				s_instance = (ThisType*)s_buffer;
				new (s_buffer)ThisType(PrimitiveTypeTraits<T>::s_typeName);
			}
			return s_instance;
		}
		virtual void op_negate(void* dst, const void* arg)
		{}
		virtual void op_decrement(void* dst, void* arg)
		{
			*reinterpret_cast<T*>(dst) = --*reinterpret_cast<T*>(arg);
		}
		virtual void op_postDecrement(void* dst, void* arg)
		{
			*reinterpret_cast<T*>(dst) = (*reinterpret_cast<T*>(arg))--;
		}
	};

	template<typename T>
	class PAFCORE_EXPORT PrimitiveTypeImpl_AllowNegate : public PrimitiveTypeImpl_Integer<T>
	{
	public:
		typedef PrimitiveTypeImpl_AllowNegate<T> ThisType;
	public:
		PrimitiveTypeImpl_AllowNegate(const char* name) : PrimitiveTypeImpl_Integer(name)
		{}
		static ThisType* GetSingleton()
		{
			static ThisType* s_instance = 0;
			static char s_buffer[sizeof(ThisType)];
			if (0 == s_instance)
			{
				s_instance = (ThisType*)s_buffer;
				new (s_buffer)ThisType(PrimitiveTypeTraits<T>::s_typeName);
			}
			return s_instance;
		}
		virtual void op_negate(void* dst, const void* arg)
		{
			*reinterpret_cast<T*>(dst) = -*reinterpret_cast<const T*>(arg);
		}
		virtual void op_decrement(void* dst, void* arg)
		{
			*reinterpret_cast<T*>(dst) = --*reinterpret_cast<T*>(arg);
		}
		virtual void op_postDecrement(void* dst, void* arg)
		{
			*reinterpret_cast<T*>(dst) = (*reinterpret_cast<T*>(arg))--;
		}
	};

	template<typename T>
	class PAFCORE_EXPORT PrimitiveTypeImpl_Real : public PrimitiveTypeImpl<T>
	{
	public:
		typedef PrimitiveTypeImpl_Real<T> ThisType;
	public:
		PrimitiveTypeImpl_Real(const char* name) : PrimitiveTypeImpl(name)
		{}
		static ThisType* GetSingleton()
		{
			static ThisType* s_instance = 0;
			static char s_buffer[sizeof(ThisType)];
			if (0 == s_instance)
			{
				s_instance = (ThisType*)s_buffer;
				new (s_buffer)ThisType(PrimitiveTypeTraits<T>::s_typeName);
			}
			return s_instance;
		}
		virtual void op_negate(void* dst, const void* arg)
		{
			*reinterpret_cast<T*>(dst) = -*reinterpret_cast<const T*>(arg);
		}
		virtual void op_increment(void* dst, void* arg)
		{}
		virtual void op_postIncrement(void* dst, void* arg)
		{}
		virtual void op_decrement(void* dst, void* arg)
		{}
		virtual void op_postDecrement(void* dst, void* arg)
		{}
		virtual void op_bitwiseNot(void* dst, const void* arg)
		{}
		void op_mod(void* dst, const void* arg1, const void* arg2)
		{}
		virtual void op_bitwiseAnd(void* dst, const void* arg1, const void* arg2)
		{}
		virtual void op_bitwiseOr(void* dst, const void* arg1, const void* arg2)
		{}
		virtual void op_bitwiseXor(void* dst, const void* arg1, const void* arg2)
		{}
		virtual void op_leftShift(void* dst, const void* arg1, const void* arg2)
		{}
		virtual void op_rightShift(void* dst, const void* arg1, const void* arg2)
		{}
	};

	typedef PrimitiveTypeImpl_Bool<bool>						BoolType;
	typedef PrimitiveTypeImpl_AllowNegate<char>					CharType;
	typedef PrimitiveTypeImpl_AllowNegate<signed char>			SignedCharType;
	typedef PrimitiveTypeImpl_AllowNegate<unsigned char>		UnsignedCharType;
	typedef PrimitiveTypeImpl_AllowNegate<wchar_t>				WcharType;
	typedef PrimitiveTypeImpl_AllowNegate<short>				ShortType;
	typedef PrimitiveTypeImpl_AllowNegate<unsigned short>		UnsignedShortType;
	typedef PrimitiveTypeImpl_AllowNegate<int>					IntType;
	typedef PrimitiveTypeImpl_ForbidNegate<unsigned int>		UnsignedIntType;
	typedef PrimitiveTypeImpl_AllowNegate<long>					LongType;
	typedef PrimitiveTypeImpl_ForbidNegate<unsigned long>		UnsignedLongType;
	typedef PrimitiveTypeImpl_AllowNegate<long long>			LongLongType;
	typedef PrimitiveTypeImpl_ForbidNegate<unsigned long long>	UnsignedLongLongType;
	typedef PrimitiveTypeImpl_Real<float>						FloatType;
	typedef PrimitiveTypeImpl_Real<double>						DoubleType;
	typedef PrimitiveTypeImpl_Real<long double>					LongDoubleType;

	*$
}

$*
template<>
struct RuntimeTypeOf<bool>
{
	typedef ::pafcore::BoolType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<char>
{
	typedef ::pafcore::CharType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<signed char>
{
	typedef ::pafcore::SignedCharType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<unsigned char>
{
	typedef ::pafcore::UnsignedCharType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<wchar_t>
{
	typedef ::pafcore::WcharType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<short>
{
	typedef ::pafcore::ShortType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<unsigned short>
{
	typedef ::pafcore::UnsignedShortType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<long>
{
	typedef ::pafcore::LongType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<unsigned long>
{
	typedef ::pafcore::UnsignedLongType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<long long>
{
	typedef ::pafcore::LongLongType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<unsigned long long>
{
	typedef ::pafcore::UnsignedLongLongType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<int>
{
	typedef ::pafcore::IntType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<unsigned int>
{
	typedef ::pafcore::UnsignedIntType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<float>
{
	typedef ::pafcore::FloatType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<double>
{
	typedef ::pafcore::DoubleType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<>
struct RuntimeTypeOf<long double>
{
	typedef ::pafcore::LongDoubleType RuntimeType;
	enum {type_category = ::pafcore::primitive_object};
};

template<typename T>
struct RuntimeTypeOf<T*>
{
	typedef RuntimeTypeOf<size_t>::RuntimeType RuntimeType;
	enum { type_category = ::pafcore::primitive_object };
};

#pragma warning( pop ) 
*$