// Experimental code to implement GHDL <-> C API
//

#ifdef APIDEF_UNINITIALIZE
#	undef _T
#	undef TYPE_DEF
#	undef API_DEF
#	undef ARG
#	undef ARGO
#	undef ARGIO
#	undef DEFTYPE_EXPLICIT
#	undef DEFTYPE_SLV
#else

// Run the actual definition:

#define SHIFT_ARGS(x, ...) __VA_ARGS__

#if defined(RUN_TYPES)
#	define _T(t) s_vhdl_type_##t
#	define TYPE_DEF(nm) \
	static const char _T(nm)[] = #nm;
#	define DEFTYPE_EXPLICIT(t, def) \
	static const char _T(t)[] = #t;
#	define DEFTYPE_SLV(t, s) \
	static const char _T(t)[] = #t;
#	define API_DEF(t, nm, ret, ...)
#elif defined(RUN_CHEAD)
#	define _T(t) t##_ghdl
#	define TYPE_DEF(nm)
#	define DEFTYPE_EXPLICIT(t, def) \
	typedef def _T(t);
#	define DEFTYPE_SLV(t, s) \
	typedef char _T(t)[s];
#	define API_DEF(t, nm, ret, ...) \
	ret sim_##nm(__VA_ARGS__);
#	define ARG(n, t) _T(t) n
#	define ARGO(n, t) ARG(n, t)
#	define ARGIO(n, t) ARG(n, t)
#else
#	define _T(t) s_vhdl_type_##t
#	define TYPE_DEF(nm)
#	define DEFTYPE_EXPLICIT(t, def)
#	define DEFTYPE_SLV(t, s)
#	define ARG(n, t) #n, _T(t), 0
#	define ARGO(n, t) #n, _T(t), "out"
#	define ARGIO(n, t) #n, _T(t), "inout"
#	define API_DEF(t, nm, ret, ...) \
	{ .type = t, .name = #nm, .retitem = ret, \
	.parameters = { __VA_ARGS__, NULL }},

#endif

#define API_DEFFUNC(...) API_DEF(TYPE_FUNC, __VA_ARGS__)
#define API_DEFPROC(...) API_DEF(TYPE_PROC, __VA_ARGS__)

// Standard simple types:

/** A 32 bit signed integer */
DEFTYPE_EXPLICIT(integer, int32_t)
/** A GHDL interface 'fat pointer' */
DEFTYPE_EXPLICIT(string, struct fat_pointer *)
/** Pointer to constrained unsigned array */
DEFTYPE_EXPLICIT(unsigned, char *)
/** Void */
DEFTYPE_EXPLICIT(void, void)

#define DEFTYPE_HANDLE32(t) DEFTYPE_EXPLICIT(t, uint32_t)
#define DEFTYPE_FATP(t)     DEFTYPE_EXPLICIT(t, struct fat_pointer *)

#	define ARG_O(n, t) _T(t) n

#endif // UNINITIALIZE
