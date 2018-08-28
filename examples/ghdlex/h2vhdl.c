/** API generator for VHDL */

#include "ghpi.h"
#include <stdio.h>
#include <string.h>

// The C function prefix
#define PREFIX "sim_"

#if 0
#define none "none"
#define token_t "token_t"
#define integer "integer"
#define pixel_t "pixel_t"
#define pixarray_t "pixarray_t"
#define framebuffer_t "integer"
#define netpphandle_t "integer"
#define string "string"
#endif
enum {
	TYPE_FUNC,
	TYPE_PROC,
};

struct param_desc {
	char *name;
	char *type;
};


#define RUN_TYPES
#include "apidef.h"
#undef RUN_TYPES
struct ghdl_apidesc {
	char *name;
	int type;
	const char *retitem;
	const char *parameters[16];
} g_api[] = {
#include "apidef.h"
	{ .name = NULL }
};

int dump_header(FILE *f, char *item, struct ghdl_apidesc *d)
{
	char const **p;
	int i = 0;

	fprintf(f, "%s %s", item, d->name);
	p = d->parameters;
	if (p[0]) {
		if (p[2]) {
			fprintf(f, "(%s : %s %s", p[0], p[2], p[1]);
		} else {
			fprintf(f, "(%s : %s", p[0], p[1]);
		}
		p += 3; i++;
	}
	while (p[0]) {
		if (p[2]) {
			fprintf(f, "; %s : %s %s", p[0], p[2], p[1]);
		} else {
			fprintf(f, "; %s : %s", p[0], p[1]);
		}
		p += 3; i++;
	}
	return i;
}

void dump_func_decl(FILE *f, struct ghdl_apidesc *d)
{
	dump_header(f, "function", d);
	fprintf(f, ") return %s", d->retitem);
	fprintf(f, ";\n");
	fprintf(f, "\tattribute foreign of %s :\n"
		"\t\tfunction is \"VHPIDIRECT %s%s\";\n\n", d->name, PREFIX, d->name);
}

void dump_proc_decl(FILE *f, struct ghdl_apidesc *d)
{
	int i;
	i = dump_header(f, "procedure", d);
	if (i) {
		fprintf(f, ");\n");
	} else {
		fprintf(f, ";\n");
	}
	fprintf(f, "\tattribute foreign of %s :\n"
		"\t\tprocedure is \"VHPIDIRECT %s%s\";\n\n", d->name, PREFIX, d->name);
}
void dump_func_body(FILE *f, struct ghdl_apidesc *d)
{
	int i;
	i = dump_header(f, "function", d);
	if (i) {
		fprintf(f, ") return %s is\n", d->retitem);
	} else {
		fprintf(f, " return %s is\n", d->retitem);
	}
	fprintf(f,
	"begin\n"
		"\tassert false report \"VHPI\" severity failure;\n"
	"end function;\n\n");
}

void dump_proc_body(FILE *f, struct ghdl_apidesc *d)
{
	int i;
	i = dump_header(f, "procedure", d);
	if (i) {
		fprintf(f, ") is\n");
	} else {
		fprintf(f, " is\n");
	}
	fprintf(f,
	"begin\n"
		"\tassert false report \"VHPI\" severity failure;\n"
	"end procedure;\n\n");
}

int dump_decl(FILE *f)
{
	struct ghdl_apidesc *d = g_api;
	// struct param_desc *p;

	while(d->name) {
		switch (d->type) {
			case TYPE_FUNC:
				dump_func_decl(f, d);
				break;
			default:
				dump_proc_decl(f, d);
		}
		d++;
	}
	return 0;
}

int dump_body(FILE *f)
{
	struct ghdl_apidesc *d = g_api;
	d = g_api;
	while(d->name) {
		switch (d->type) {
			case TYPE_FUNC:
				dump_func_body(f, d);
				break;
			default:
				dump_proc_body(f, d);
		}
		d++;
	}
	return 0;
}

const char g_line[] = 
"----------------------------------------------------------------------\n";

FILE *create_file(const char *fname, const char *rule)
{
	FILE *f;
	char filename[256];
	snprintf(filename, sizeof(filename) - 1, rule, fname);
	f = fopen(filename, "w");
	if (!f) {
		fprintf(stderr, "Failed to open file for writing\n");
	}
	return f;
}

int main(int argc, char **argv)
{
	FILE *f;
	if (argc == 2) {
		f = create_file(argv[1], "%s_decl.chdl");
		if (f) {
			dump_decl(f);
			fclose(f);
		}
		f = create_file(argv[1], "%s_body.chdl");
		if (f) {
			dump_body(f);
			fclose(f);
		}
	} else {
		printf(g_line);
		return dump_decl(stdout);
		printf(g_line);
		return dump_body(stdout);
	}
	return 0;
}
