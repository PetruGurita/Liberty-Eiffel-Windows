note
	description: "Windows -- Onscreen display areas in the target window system."
	copyright: "[
					Copyright (C) 2006 eiffel-libraries team, GTK+ team
					
					This library is free software; you can redistribute it and/or
					modify it under the terms of the GNU Lesser General Public License
					as published by the Free Software Foundation; either version 2.1 of
					the License, or (at your option) any later version.
					
					This library is distributed in the hope that it will be useful, but
					WITHOUT ANY WARRANTY; without even the implied warranty of
					MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
					Lesser General Public License for more details.

					You should have received a copy of the GNU Lesser General Public
					License along with this library; if not, write to the Free Software
					Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
					02110-1301 USA
				]"
class GDK_WINDOW
	-- A GdkWindow is a rectangular region on the screen. It's a low-level
	-- object, used to implement high-level objects such as GtkWidget and
	-- GtkWindow on the GTK+ level. A GtkWindow is a toplevel window, the thing
	-- a user might think of as a "window" with a titlebar and so on; a
	-- GtkWindow may contain many GdkWindow. For example, each GtkButton has a
	-- GdkWindow associated with it.

inherit GDK_DRAWABLE

insert
	GDK_WINDOW_EXTERNALS
	GDK_MODIFIER_TYPE

create {WRAPPER, WRAPPER_HANDLER} from_external_pointer, secondary_wrapper_from

feature {ANY} -- size
	struct_size: INTEGER is
		external "C inline use <gdk/gdk.h>"
		alias "sizeof(GdkWindow)"
		end

feature {ANY}

	set_cursor (a_cursor: GDK_CURSOR) is
		require
			a_cursor /= Void
		do
			gdk_window_set_cursor (handle, a_cursor.handle)
		end

	unset_cursor is
		do
			gdk_window_set_cursor (handle, default_pointer)
		end

	get_pointer: TUPLE [GDK_WINDOW, INTEGER, INTEGER, INTEGER] is
			-- GdkWindow*  gdk_window_get_pointer          (GdkWindow *window,
			--                                              gint *x,
			--                                              gint *y,
			--                                              GdkModifierType *mask);
		local
			res: POINTER
			window: GDK_WINDOW
			x, y, mask: INTEGER
			factory: G_OBJECT_EXPANDED_FACTORY [GDK_WINDOW]
		do
			res := gdk_window_get_pointer (handle, $x, $y, $mask)
			if res.is_not_null then
				window := factory.existant_wrapper (res)
				if window=Void then 
					create window.from_external_pointer (res)
				end
			end
			mask := mask & gdk_modifier_mask
			Result := [window, x, y, mask]
		ensure
			Result /= Void implies is_valid_gdk_modifier_type (Result.fourth)
		end
	
	children: G_LIST [GDK_WINDOW] is
		do
			create {G_OBJECT_LIST[GDK_WINDOW]} Result.from_external_pointer(gdk_window_get_children(handle))
		end

	-- GList*      gdk_window_peek_children        (GdkWindow *window);
	-- GdkEventMask gdk_window_get_events          (GdkWindow *window);
	-- void        gdk_window_set_events           (GdkWindow *window,
	--                                              GdkEventMask event_mask);
	-- void        gdk_window_set_icon             (GdkWindow *window,
	--                                              GdkWindow *icon_window,
	--                                              GdkPixmap *pixmap,
	--                                              GdkBitmap *mask);
	-- void        gdk_window_set_icon_name        (GdkWindow *window,
	--                                              const gchar *name);
	-- void        gdk_window_set_transient_for    (GdkWindow *window,
	--                                              GdkWindow *parent);
	-- void        gdk_window_set_role             (GdkWindow *window,
	--                                              const gchar *role);
	-- void        gdk_window_set_group            (GdkWindow *window,
	--                                              GdkWindow *leader);
	-- GdkWindow*  gdk_window_get_group            (GdkWindow *window);
	-- void        gdk_window_set_decorations      (GdkWindow *window,
	--                                              GdkWMDecoration decorations);
	-- gboolean    gdk_window_get_decorations      (GdkWindow *window,
	--                                              GdkWMDecoration *decorations);
	-- enum        GdkWMDecoration;
	-- void        gdk_window_set_functions        (GdkWindow *window,
	--                                              GdkWMFunction functions);
	-- enum        GdkWMFunction;
	-- GList*      gdk_window_get_toplevels        (void);
	-- GdkWindow*  gdk_get_default_root_window     (void);

	--             GdkPointerHooks;
	-- GdkPointerHooks* gdk_set_pointer_hooks      (const GdkPointerHooks *new_hooks);

	-- An opaque structure representing an onscreen drawable. Pointers to structures of type GdkPixmap, GdkBitmap, and GdkWindow, can often be used interchangeably. The type GdkDrawable refers generically to any of these types.
	-- enum GdkWindowType

	-- typedef enum
	-- {
	--   GDK_WINDOW_ROOT,
	--   GDK_WINDOW_TOPLEVEL,
	--   GDK_WINDOW_CHILD,
	--   GDK_WINDOW_DIALOG,
	--   GDK_WINDOW_TEMP,
	--   GDK_WINDOW_FOREIGN
	-- } GdkWindowType;

	-- Describes the kind of window.
	-- GDK_WINDOW_ROOT 	root window; this window has no parent, covers the entire screen, and is created by the window system
	-- GDK_WINDOW_TOPLEVEL 	toplevel window (used to implement GtkWindow)
	-- GDK_WINDOW_CHILD 	child window (used to implement e.g. GtkButton)
	-- GDK_WINDOW_DIALOG 	useless/deprecated compatibility type
	-- GDK_WINDOW_TEMP 	override redirect temporary window (used to implement GtkMenu)
	-- GDK_WINDOW_FOREIGN 	foreign window (see gdk_window_foreign_new())
	-- enum GdkWindowClass

	-- typedef enum
	-- {
	--   GDK_INPUT_OUTPUT,
	--   GDK_INPUT_ONLY
	-- } GdkWindowClass;

	-- GDK_INPUT_OUTPUT windows are the standard kind of window you might expect. GDK_INPUT_ONLY windows are invisible; they are used to trap events, but you can't draw on them.
	-- GDK_INPUT_OUTPUT 	window for graphics and events
	-- GDK_INPUT_ONLY 	window for events only
	-- enum GdkWindowHints

	-- typedef enum
	-- {
	--   GDK_HINT_POS	       = 1 < < 0,
	--   GDK_HINT_MIN_SIZE    = 1 < < 1,
	--   GDK_HINT_MAX_SIZE    = 1 < < 2,
	--   GDK_HINT_BASE_SIZE   = 1 < < 3,
	--   GDK_HINT_ASPECT      = 1 < < 4,
	--   GDK_HINT_RESIZE_INC  = 1 < < 5,
	--   GDK_HINT_WIN_GRAVITY = 1 < < 6,
	--   GDK_HINT_USER_POS    = 1 < < 7,
	--   GDK_HINT_USER_SIZE   = 1 < < 8
	-- } GdkWindowHints;

	-- Used to indicate which fields of a GdkGeometry struct should be paid attention to. Also, the presence/absence of GDK_HINT_POS, GDK_HINT_USER_POS, and GDK_HINT_USER_SIZE is significant, though they don't directly refer to GdkGeometry fields. GDK_HINT_USER_POS will be set automatically by GtkWindow if you call gtk_window_move(). GDK_HINT_USER_POS and GDK_HINT_USER_SIZE should be set if the user specified a size/position using a --geometry command-line argument; gtk_window_parse_geometry() automatically sets these flags.
	-- GDK_HINT_POS 	indicates that the program has positioned the window
	-- GDK_HINT_MIN_SIZE 	min size fields are set
	-- GDK_HINT_MAX_SIZE 	max size fields are set
	-- GDK_HINT_BASE_SIZE 	base size fields are set
	-- GDK_HINT_ASPECT 	aspect ratio fields are set
	-- GDK_HINT_RESIZE_INC 	resize increment fields are set
	-- GDK_HINT_WIN_GRAVITY 	window gravity field is set
	-- GDK_HINT_USER_POS 	indicates that the window's position was explicitly set by the user
	-- GDK_HINT_USER_SIZE 	indicates that the window's size was explicitly set by the user
	-- GdkGeometry

	-- typedef struct {
	--   gint min_width;
	--   gint min_height;
	--   gint max_width;
	--   gint max_height;
	--   gint base_width;
	--   gint base_height;
	--   gint width_inc;
	--   gint height_inc;
	--   gdouble min_aspect;
	--   gdouble max_aspect;
	--   GdkGravity win_gravity;
	-- } GdkGeometry;

	-- The GdkGeometry struct gives the window manager information about a window's geometry constraints. Normally you would set these on the GTK+ level using gtk_window_set_geometry_hints(). GtkWindow then sets the hints on the GdkWindow it creates.

	-- gdk_window_set_geometry_hints() expects the hints to be fully valid already and simply passes them to the window manager; in contrast, gtk_window_set_geometry_hints() performs some interpretation. For example, GtkWindow will apply the hints to the geometry widget instead of the toplevel window, if you set a geometry widget. Also, the min_width/min_height/max_width/max_height fields may be set to -1, and GtkWindow will substitute the size request of the window or geometry widget. If the minimum size hint is not provided, GtkWindow will use its requisition as the minimum size. If the minimum size is provided and a geometry widget is set, GtkWindow will take the minimum size as the minimum size of the geometry widget rather than the entire window. The base size is treated similarly.

	-- The canonical use-case for gtk_window_set_geometry_hints() is to get a terminal widget to resize properly. Here, the terminal text area should be the geometry widget; GtkWindow will then automatically set the base size to the size of other widgets in the terminal window, such as the menubar and scrollbar. Then, the width_inc and height_inc fields should be set to the size of one character in the terminal. Finally, the base size should be set to the size of one character. The net effect is that the minimum size of the terminal will have a 1x1 character terminal area, and only terminal sizes on the "character grid" will be allowed.

	-- Here's an example of how the terminal example would be implemented, assuming a terminal area widget called "terminal" and a toplevel window "toplevel":

	-- 	GdkGeometry hints;

	-- 	hints.base_width = terminal->char_width;
	--         hints.base_height = terminal->char_height;
	--         hints.min_width = terminal->char_width;
	--         hints.min_height = terminal->char_height;
	--         hints.width_inc = terminal->char_width;
	--         hints.height_inc = terminal->char_height;

	-- 	gtk_window_set_geometry_hints (GTK_WINDOW (toplevel),
	-- 				       GTK_WIDGET (terminal),
	--  				       &hints,
	-- 				       GDK_HINT_RESIZE_INC |
	--                                        GDK_HINT_MIN_SIZE |
	--                                        GDK_HINT_BASE_SIZE);

	-- The other useful fields are the min_aspect and max_aspect fields; these contain a width/height ratio as a floating point number. If a geometry widget is set, the aspect applies to the geometry widget rather than the entire window. The most common use of these hints is probably to set min_aspect and max_aspect to the same value, thus forcing the window to keep a constant aspect ratio.
	-- gint min_width; 	minimum width of window (or -1 to use requisition, with GtkWindow only) min_height minimum height of window (or -1 to use requisition, with GtkWindow only)
	-- gint min_height; 	
	-- gint max_width; 	maximum width of window (or -1 to use requisition, with GtkWindow only)
	-- gint max_height; 	maximum height of window (or -1 to use requisition, with GtkWindow only)
	-- gint base_width; 	allowed window widths are base_width + width_inc * N where N is any integer (-1 allowed with GtkWindow)
	-- gint base_height; 	allowed window widths are base_height + height_inc * N where N is any integer (-1 allowed with GtkWindow)
	-- gint width_inc; 	width resize increment
	-- gint height_inc; 	height resize increment
	-- gdouble min_aspect; 	minimum width/height ratio
	-- gdouble max_aspect; 	maximum width/height ratio
	-- GdkGravity win_gravity; 	window gravity, see gtk_window_set_gravity()
	-- enum GdkGravity

	-- typedef enum
	-- {
	--   GDK_GRAVITY_NORTH_WEST = 1,
	--   GDK_GRAVITY_NORTH,
	--   GDK_GRAVITY_NORTH_EAST,
	--   GDK_GRAVITY_WEST,
	--   GDK_GRAVITY_CENTER,
	--   GDK_GRAVITY_EAST,
	--   GDK_GRAVITY_SOUTH_WEST,
	--   GDK_GRAVITY_SOUTH,
	--   GDK_GRAVITY_SOUTH_EAST,
	--   GDK_GRAVITY_STATIC
	-- } GdkGravity;

	-- Defines the reference point of a window and the meaning of coordinates passed to gtk_window_move(). See gtk_window_move() and the "implementation notes" section of the Extended Window Manager Hints specification for more details.
	-- GDK_GRAVITY_NORTH_WEST 	the reference point is at the top left corner.
	-- GDK_GRAVITY_NORTH 	the reference point is in the middle of the top edge.
	-- GDK_GRAVITY_NORTH_EAST 	the reference point is at the top right corner.
	-- GDK_GRAVITY_WEST 	the reference point is at the middle of the left edge.
	-- GDK_GRAVITY_CENTER 	the reference point is at the center of the window.
	-- GDK_GRAVITY_EAST 	the reference point is at the middle of the right edge.
	-- GDK_GRAVITY_SOUTH_WEST 	the reference point is at the lower left corner.
	-- GDK_GRAVITY_SOUTH 	the reference point is at the middle of the lower edge.
	-- GDK_GRAVITY_SOUTH_EAST 	the reference point is at the lower right corner.
	-- GDK_GRAVITY_STATIC 	the reference point is at the top left corner of the window itself, ignoring window manager decorations.
	-- enum GdkWindowEdge

	-- typedef enum
	-- {
	--   GDK_WINDOW_EDGE_NORTH_WEST,
	--   GDK_WINDOW_EDGE_NORTH,
	--   GDK_WINDOW_EDGE_NORTH_EAST,
	--   GDK_WINDOW_EDGE_WEST,
	--   GDK_WINDOW_EDGE_EAST,
	--   GDK_WINDOW_EDGE_SOUTH_WEST,
	--   GDK_WINDOW_EDGE_SOUTH,
	--   GDK_WINDOW_EDGE_SOUTH_EAST  
	-- } GdkWindowEdge;

	-- Determines a window edge or corner.
	-- GDK_WINDOW_EDGE_NORTH_WEST 	the top left corner.
	-- GDK_WINDOW_EDGE_NORTH 	the top edge.
	-- GDK_WINDOW_EDGE_NORTH_EAST 	the top right corner.
	-- GDK_WINDOW_EDGE_WEST 	the left edge.
	-- GDK_WINDOW_EDGE_EAST 	the right edge.
	-- GDK_WINDOW_EDGE_SOUTH_WEST 	the lower left corner.
	-- GDK_WINDOW_EDGE_SOUTH 	the lower edge.
	-- GDK_WINDOW_EDGE_SOUTH_EAST 	the lower right corner.
	-- enum GdkWindowTypeHint

	-- typedef enum
	-- {
	--   GDK_WINDOW_TYPE_HINT_NORMAL,
	--   GDK_WINDOW_TYPE_HINT_DIALOG,
	--   GDK_WINDOW_TYPE_HINT_MENU,
	--   GDK_WINDOW_TYPE_HINT_TOOLBAR,
	--   GDK_WINDOW_TYPE_HINT_SPLASHSCREEN,
	--   GDK_WINDOW_TYPE_HINT_UTILITY,
	--   GDK_WINDOW_TYPE_HINT_DOCK,
	--   GDK_WINDOW_TYPE_HINT_DESKTOP
	-- } GdkWindowTypeHint;

	-- These are hints for the window manager that indicate what type of function the window has. The window manager can use this when determining decoration and behaviour of the window. The hint must be set before mapping the window.

	-- See the Extended Window Manager Hints specification for more details about window types.
	-- GDK_WINDOW_TYPE_HINT_NORMAL 	Normal toplevel window.
	-- GDK_WINDOW_TYPE_HINT_DIALOG 	Dialog window.
	-- GDK_WINDOW_TYPE_HINT_MENU 	Window used to implement a menu.
	-- GDK_WINDOW_TYPE_HINT_TOOLBAR 	Window used to implement toolbars.
	-- GDK_WINDOW_TYPE_HINT_SPLASHSCREEN 	Window used to display a splash screen during application startup.
	-- GDK_WINDOW_TYPE_HINT_UTILITY 	Utility windows which are not detached toolbars or dialogs.
	-- GDK_WINDOW_TYPE_HINT_DOCK 	Used for creating dock or panel windows.
	-- GDK_WINDOW_TYPE_HINT_DESKTOP 	Used for creating the desktop background window.
	-- GdkWindowAttr

	-- typedef struct {
	--   gchar *title;
	--   gint event_mask;
	--   gint x, y;
	--   gint width;
	--   gint height;
	--   GdkWindowClass wclass;
	--   GdkVisual *visual;
	--   GdkColormap *colormap;
	--   GdkWindowType window_type;
	--   GdkCursor *cursor;
	--   gchar *wmclass_name;
	--   gchar *wmclass_class;
	--   gboolean override_redirect;
	-- } GdkWindowAttr;

	-- Attributes to use for a newly-created window.
	-- gchar *title; 	title of the window (for toplevel windows)
	-- gint event_mask; 	event mask (see gdk_window_set_events())
	-- gint x; 	X coordinate relative to parent window (see gdk_window_move())
	-- gint y; 	Y coordinate relative to parent window (see gdk_window_move())
	-- gint width; 	width of window
	-- gint height; 	height of window
	-- GdkWindowClass wclass; 	GDK_INPUT_OUTPUT (normal window) or GDK_INPUT_ONLY (invisible window that receives events)
	-- GdkVisual *visual; 	GdkVisual for window
	-- GdkColormap *colormap; 	GdkColormap for window
	-- GdkWindowType window_type; 	type of window
	-- GdkCursor *cursor; 	cursor for the window (see gdk_window_set_cursor())
	-- gchar *wmclass_name; 	don't use (see gtk_window_set_wmclass())
	-- gchar *wmclass_class; 	don't use (see gtk_window_set_wmclass())
	-- gboolean override_redirect; 	TRUE to bypass the window manager
	-- enum GdkWindowAttributesType

	-- typedef enum
	-- {
	--   GDK_WA_TITLE	  = 1 < < 1,
	--   GDK_WA_X	  = 1 < < 2,
	--   GDK_WA_Y	  = 1 < < 3,
	--   GDK_WA_CURSOR	  = 1 < < 4,
	--   GDK_WA_COLORMAP = 1 < < 5,
	--   GDK_WA_VISUAL	  = 1 < < 6,
	--   GDK_WA_WMCLASS  = 1 < < 7,
	--   GDK_WA_NOREDIR  = 1 < < 8
	-- } GdkWindowAttributesType;

	-- Used to indicate which fields in the GdkWindowAttr struct should be honored. For example, if you filled in the "cursor" and "x" fields of GdkWindowAttr, pass "GDK_WA_X | GDK_WA_CURSOR" to gdk_window_new(). Fields in GdkWindowAttr not covered by a bit in this enum are required; for example, the width/height, wclass, and window_type fields are required, they have no corresponding flag in GdkWindowAttributesType.
	-- GDK_WA_TITLE 	Honor the title field
	-- GDK_WA_X 	Honor the X coordinate field
	-- GDK_WA_Y 	Honor the Y coordinate field
	-- GDK_WA_CURSOR 	Honor the cursor field
	-- GDK_WA_COLORMAP 	Honor the colormap field
	-- GDK_WA_VISUAL 	Honor the visual field
	-- GDK_WA_WMCLASS 	Honor the wmclass_class and wmclass_name fields
	-- GDK_WA_NOREDIR 	Honor the override_redirect field
	-- gdk_window_new ()

	-- GdkWindow*  gdk_window_new                  (GdkWindow *parent,
	--                                              GdkWindowAttr *attributes,
	--                                              gint attributes_mask);

	-- Creates a new GdkWindow using the attributes from attributes. See GdkWindowAttr and GdkWindowAttributesType for more details. Note: to use this on displays other than the default display, parent must be specified.

	-- parent : 	a GdkWindow, or NULL to create the window as a child of the default root window for the default display.
	-- attributes : 	attributes of the new window
	-- attributes_mask : 	mask indicating which fields in attributes are valid
	-- Returns : 	the new GdkWindow
	-- gdk_window_destroy ()

	-- void        gdk_window_destroy              (GdkWindow *window);

	-- Destroys the window system resources associated with window and decrements window's reference count. The window system resources for all children of window are also destroyed, but the children's reference counts are not decremented.

	-- Note that a window will not be destroyed automatically when its reference count reaches zero. You must call this function yourself before that happens.

	-- window : 	a GdkWindow
	-- gdk_window_ref

	-- #define gdk_window_ref                 gdk_drawable_ref

	-- Warning

	-- gdk_window_ref is deprecated and should not be used in newly-written code.

	-- Deprecated equivalent of g_object_ref()
	-- Returns : 	the window
	-- gdk_window_unref

	-- #define gdk_window_unref               gdk_drawable_unref

	-- Warning

	-- gdk_window_unref is deprecated and should not be used in newly-written code.

	-- Deprecated equivalent of g_object_unref()
	-- gdk_window_get_window_type ()

	-- GdkWindowType gdk_window_get_window_type    (GdkWindow *window);

	-- Gets the type of the window. See GdkWindowType.

	-- window : 	a GdkWindow
	-- Returns : 	type of window
	-- gdk_window_at_pointer ()

	-- GdkWindow*  gdk_window_at_pointer           (gint *win_x,
	--                                              gint *win_y);

	-- Obtains the window underneath the mouse pointer, returning the location of that window in win_x, win_y. Returns NULL if the window under the mouse pointer is not known to GDK (if the window belongs to another application and a GdkWindow hasn't been created for it with gdk_window_foreign_new())

	-- NOTE: For multihead-aware widgets or applications use gdk_display_get_window_at_pointer() instead.

	-- win_x : 	return location for origin of the window under the pointer
	-- win_y : 	return location for origin of the window under the pointer
	-- Returns : 	window under the mouse pointer
	-- gdk_window_show ()

	-- void        gdk_window_show                 (GdkWindow *window);

	-- Like gdk_window_show_unraised(), but also raises the window to the top of the window stack (moves the window to the front of the Z-order).

	-- This function maps a window so it's visible onscreen. Its opposite is gdk_window_hide().

	-- When implementing a GtkWidget, you should call this function on the widget's GdkWindow as part of the "map" method.

	-- window : 	a GdkWindow
	-- gdk_window_show_unraised ()

	-- void        gdk_window_show_unraised        (GdkWindow *window);

	-- Shows a GdkWindow onscreen, but does not modify its stacking order. In contrast, gdk_window_show() will raise the window to the top of the window stack.

	-- On the X11 platform, in Xlib terms, this function calls XMapWindow() (it also updates some internal GDK state, which means that you can't really use XMapWindow() directly on a GDK window).

	-- window : 	a GdkWindow
	-- gdk_window_hide ()

	-- void        gdk_window_hide                 (GdkWindow *window);

	-- For toplevel windows, withdraws them, so they will no longer be known to the window manager; for all windows, unmaps them, so they won't be displayed. Normally done automatically as part of gtk_widget_hide().

	-- window : 	a GdkWindow
	-- gdk_window_is_visible ()

	-- gboolean    gdk_window_is_visible           (GdkWindow *window);

	-- Checks whether the window has been mapped (with gdk_window_show() or gdk_window_show_unraised()).

	-- window : 	a GdkWindow
	-- Returns : 	TRUE if the window is mapped
	-- gdk_window_is_viewable ()

	-- gboolean    gdk_window_is_viewable          (GdkWindow *window);

	-- Check if the window and all ancestors of the window are mapped. (This is not necessarily "viewable" in the X sense, since we only check as far as we have GDK window parents, not to the root window.)

	-- window : 	a GdkWindow
	-- Returns : 	TRUE if the window is viewable
	-- gdk_window_get_state ()

	-- GdkWindowState gdk_window_get_state         (GdkWindow *window);

	-- Gets the bitwise OR of the currently active window state flags, from the GdkWindowState enumeration.

	-- window : 	a GdkWindow
	-- Returns : 	window state bitfield
	-- gdk_window_withdraw ()

	-- void        gdk_window_withdraw             (GdkWindow *window);

	-- Withdraws a window (unmaps it and asks the window manager to forget about it). This function is not really useful as gdk_window_hide() automatically withdraws toplevel windows before hiding them.

	-- window : 	a toplevel GdkWindow
	-- gdk_window_iconify ()

	-- void        gdk_window_iconify              (GdkWindow *window);

	-- Asks to iconify (minimize) window. The window manager may choose to ignore the request, but normally will honor it. Using gtk_window_iconify() is preferred, if you have a GtkWindow widget.

	-- This function only makes sense when window is a toplevel window.

	-- window : 	a toplevel GdkWindow
	-- gdk_window_deiconify ()

	-- void        gdk_window_deiconify            (GdkWindow *window);

	-- Attempt to deiconify (unminimize) window. On X11 the window manager may choose to ignore the request to deiconify. When using GTK+, use gtk_window_deiconify() instead of the GdkWindow variant. Or better yet, you probably want to use gtk_window_present(), which raises the window, focuses it, unminimizes it, and puts it on the current desktop.

	-- window : 	a toplevel GdkWindow
	-- gdk_window_stick ()

	-- void        gdk_window_stick                (GdkWindow *window);

	-- "Pins" a window such that it's on all workspaces and does not scroll with viewports, for window managers that have scrollable viewports. (When using GtkWindow, gtk_window_stick() may be more useful.)

	-- On the X11 platform, this function depends on window manager support, so may have no effect with many window managers. However, GDK will do the best it can to convince the window manager to stick the window. For window managers that don't support this operation, there's nothing you can do to force it to happen.

	-- window : 	a toplevel GdkWindow
	-- gdk_window_unstick ()

	-- void        gdk_window_unstick              (GdkWindow *window);

	-- Reverse operation for gdk_window_stick(); see gdk_window_stick(), and gtk_window_unstick().

	-- window : 	a toplevel GdkWindow
	-- gdk_window_maximize ()

	-- void        gdk_window_maximize             (GdkWindow *window);

	-- Maximizes the window. If the window was already maximized, then this function does nothing.

	-- On X11, asks the window manager to maximize window, if the window manager supports this operation. Not all window managers support this, and some deliberately ignore it or don't have a concept of "maximized"; so you can't rely on the maximization actually happening. But it will happen with most standard window managers, and GDK makes a best effort to get it to happen.

	-- On Windows, reliably maximizes the window.

	-- window : 	a toplevel GdkWindow
	-- gdk_window_unmaximize ()

	-- void        gdk_window_unmaximize           (GdkWindow *window);

	-- Unmaximizes the window. If the window wasn't maximized, then this function does nothing.

	-- On X11, asks the window manager to unmaximize window, if the window manager supports this operation. Not all window managers support this, and some deliberately ignore it or don't have a concept of "maximized"; so you can't rely on the unmaximization actually happening. But it will happen with most standard window managers, and GDK makes a best effort to get it to happen.

	-- On Windows, reliably unmaximizes the window.

	-- window : 	a toplevel GdkWindow
	-- gdk_window_fullscreen ()

	-- void        gdk_window_fullscreen           (GdkWindow *window);

	-- Moves the window into fullscreen mode. This means the window covers the entire screen and is above any panels or task bars.

	-- If the window was already fullscreen, then this function does nothing.

	-- On X11, asks the window manager to put window in a fullscreen state, if the window manager supports this operation. Not all window managers support this, and some deliberately ignore it or don't have a concept of "fullscreen"; so you can't rely on the fullscreenification actually happening. But it will happen with most standard window managers, and GDK makes a best effort to get it to happen.

	-- window : 	a toplevel GdkWindow

	-- Since 2.2
	-- gdk_window_unfullscreen ()

	-- void        gdk_window_unfullscreen         (GdkWindow *window);

	-- Moves the window out of fullscreen mode. If the window was not fullscreen, does nothing.

	-- On X11, asks the window manager to move window out of the fullscreen state, if the window manager supports this operation. Not all window managers support this, and some deliberately ignore it or don't have a concept of "fullscreen"; so you can't rely on the unfullscreenification actually happening. But it will happen with most standard window managers, and GDK makes a best effort to get it to happen.

	-- window : 	a toplevel GdkWindow

	-- Since 2.2
	-- gdk_window_set_keep_above ()

	-- void        gdk_window_set_keep_above       (GdkWindow *window,
	--                                              gboolean setting);

	-- Set if window must be kept above other windows. If the window was already above, then this function does nothing.

	-- On X11, asks the window manager to keep window above, if the window manager supports this operation. Not all window managers support this, and some deliberately ignore it or don't have a concept of "keep above"; so you can't rely on the window being kept above. But it will happen with most standard window managers, and GDK makes a best effort to get it to happen.

	-- window : 	a toplevel GdkWindow
	-- setting : 	whether to keep window above other windows

	-- Since 2.4
	-- gdk_window_set_keep_below ()

	-- void        gdk_window_set_keep_below       (GdkWindow *window,
	--                                              gboolean setting);

	-- Set if window must be kept below other windows. If the window was already below, then this function does nothing.

	-- On X11, asks the window manager to keep window below, if the window manager supports this operation. Not all window managers support this, and some deliberately ignore it or don't have a concept of "keep below"; so you can't rely on the window being kept below. But it will happen with most standard window managers, and GDK makes a best effort to get it to happen.

	-- window : 	a toplevel GdkWindow
	-- setting : 	whether to keep window below other windows

	-- Since 2.4
	-- gdk_window_move ()

	-- void        gdk_window_move                 (GdkWindow *window,
	--                                              gint x,
	--                                              gint y);

	-- Repositions a window relative to its parent window. For toplevel windows, window managers may ignore or modify the move; you should probably use gtk_window_move() on a GtkWindow widget anyway, instead of using GDK functions. For child windows, the move will reliably succeed.

	-- If you're also planning to resize the window, use gdk_window_move_resize() to both move and resize simultaneously, for a nicer visual effect.

	-- window : 	a GdkWindow
	-- x : 	X coordinate relative to window's parent
	-- y : 	Y coordinate relative to window's parent
	-- gdk_window_resize ()

	-- void        gdk_window_resize               (GdkWindow *window,
	--                                              gint width,
	--                                              gint height);

	-- Resizes window; for toplevel windows, asks the window manager to resize the window. The window manager may not allow the resize. When using GTK+, use gtk_window_resize() instead of this low-level GDK function.

	-- Windows may not be resized below 1x1.

	-- If you're also planning to move the window, use gdk_window_move_resize() to both move and resize simultaneously, for a nicer visual effect.

	-- window : 	a GdkWindow
	-- width : 	new width of the window
	-- height : 	new height of the window
	-- gdk_window_move_resize ()

	-- void        gdk_window_move_resize          (GdkWindow *window,
	--                                              gint x,
	--                                              gint y,
	--                                              gint width,
	--                                              gint height);

	-- Equivalent to calling gdk_window_move() and gdk_window_resize(), except that both operations are performed at once, avoiding strange visual effects. (i.e. the user may be able to see the window first move, then resize, if you don't use gdk_window_move_resize().)

	-- window : 	a GdkWindow
	-- x : 	new X position relative to window's parent
	-- y : 	new Y position relative to window's parent
	-- width : 	new width
	-- height : 	new height
	-- gdk_window_scroll ()

	-- void        gdk_window_scroll               (GdkWindow *window,
	--                                              gint dx,
	--                                              gint dy);

	-- Scroll the contents of window, both pixels and children, by the given amount. window itself does not move. Portions of the window that the scroll operation brings in from offscreen areas are invalidated. The invalidated region may be bigger than what would strictly be necessary. (For X11, a minimum area will be invalidated if the window has no subwindows, or if the edges of the window's parent do not extend beyond the edges of the window. In other cases, a multi-step process is used to scroll the window which may produce temporary visual artifacts and unnecessary invalidations.)

	-- window : 	a GdkWindow
	-- dx : 	Amount to scroll in the X direction
	-- dy : 	Amount to scroll in the Y direction
	-- gdk_window_move_region ()

	-- void        gdk_window_move_region          (GdkWindow *window,
	--                                              GdkRegion *region,
	--                                              gint dx,
	--                                              gint dy);

	-- Move the part of window indicated by region by dy pixels in the Y direction and dx pixels in the X direction. The portions of region that not covered by the new position of region are invalidated.

	-- Child windows are not moved.

	-- window : 	a GdkWindow
	-- region : 	The GdkRegion to move
	-- dx : 	Amount to move in the X direction
	-- dy : 	Amount to move in the Y direction

	-- Since 2.8
	-- gdk_window_reparent ()

	-- void        gdk_window_reparent             (GdkWindow *window,
	--                                              GdkWindow *new_parent,
	--                                              gint x,
	--                                              gint y);

	-- Reparents window into the given new_parent. The window being reparented will be unmapped as a side effect.

	-- window : 	a GdkWindow
	-- new_parent : 	new parent to move window into
	-- x : 	X location inside the new parent
	-- y : 	Y location inside the new parent
	-- gdk_window_clear ()

	-- void        gdk_window_clear                (GdkWindow *window);

	-- Clears an entire window to the background color or background pixmap.

	-- window : 	a GdkWindow
	-- gdk_window_clear_area ()

	-- void        gdk_window_clear_area           (GdkWindow *window,
	--                                              gint x,
	--                                              gint y,
	--                                              gint width,
	--                                              gint height);

	-- Clears an area of window to the background color or background pixmap.

	-- window : 	a GdkWindow
	-- x : 	x coordinate of rectangle to clear
	-- y : 	y coordinate of rectangle to clear
	-- width : 	width of rectangle to clear
	-- height : 	height of rectangle to clear
	-- gdk_window_clear_area_e ()

	-- void        gdk_window_clear_area_e         (GdkWindow *window,
	--                                              gint x,
	--                                              gint y,
	--                                              gint width,
	--                                              gint height);

	-- Like gdk_window_clear_area(), but also generates an expose event for the cleared area.

	-- This function has a stupid name because it dates back to the mists time, pre-GDK-1.0.

	-- window : 	a GdkWindow
	-- x : 	x coordinate of rectangle to clear
	-- y : 	y coordinate of rectangle to clear
	-- width : 	width of rectangle to clear
	-- height : 	height of rectangle to clear
	-- gdk_window_copy_area()

	-- #define     gdk_window_copy_area(drawable,gc,x,y,source_drawable,source_x,source_y,width,height)

	-- Warning

	-- gdk_window_copy_area is deprecated and should not be used in newly-written code.

	-- Deprecated equivalent to gdk_draw_drawable(), see that function for docs
	-- drawable : 	a GdkDrawable
	-- gc : 	a GdkGC sharing the drawable's visual and colormap
	-- x : 	X position in drawable where the rectangle should be drawn
	-- y : 	Y position in drawable where the rectangle should be drawn
	-- source_drawable : 	the source GdkDrawable, which may be the same as drawable
	-- source_x : 	X position in src of rectangle to draw
	-- source_y : 	Y position in src of rectangle to draw
	-- width : 	width of rectangle to draw, or -1 for entire src width
	-- height : 	height of rectangle to draw, or -1 for entire src height
	-- gdk_window_raise ()

	-- void        gdk_window_raise                (GdkWindow *window);

	-- Raises window to the top of the Z-order (stacking order), so that other windows with the same parent window appear below window. This is true whether or not the windows are visible.

	-- If window is a toplevel, the window manager may choose to deny the request to move the window in the Z-order, gdk_window_raise() only requests the restack, does not guarantee it.

	-- window : 	a GdkWindow
	-- gdk_window_lower ()

	-- void        gdk_window_lower                (GdkWindow *window);

	-- Lowers window to the bottom of the Z-order (stacking order), so that other windows with the same parent window appear above window. This is true whether or not the other windows are visible.

	-- If window is a toplevel, the window manager may choose to deny the request to move the window in the Z-order, gdk_window_lower() only requests the restack, does not guarantee it.

	-- Note that gdk_window_show() raises the window again, so don't call this function before gdk_window_show(). (Try gdk_window_show_unraised().)

	-- window : 	a GdkWindow
	-- gdk_window_focus ()

	-- void        gdk_window_focus                (GdkWindow *window,
	--                                              guint32 timestamp);

	-- Sets keyboard focus to window. In most cases, gtk_window_present() should be used on a GtkWindow, rather than calling this function.

	-- window : 	a GdkWindow
	-- timestamp : 	timestamp of the event triggering the window focus
	-- gdk_window_register_dnd ()

	-- void        gdk_window_register_dnd         (GdkWindow *window);

	-- Registers a window as a potential drop destination.
	-- window : 	a GdkWindow.
	-- gdk_window_begin_resize_drag ()

	-- void        gdk_window_begin_resize_drag    (GdkWindow *window,
	--                                              GdkWindowEdge edge,
	--                                              gint button,
	--                                              gint root_x,
	--                                              gint root_y,
	--                                              guint32 timestamp);

	-- Begins a window resize operation (for a toplevel window). You might use this function to implement a "window resize grip," for example; in fact GtkStatusbar uses it. The function works best with window managers that support the Extended Window Manager Hints, but has a fallback implementation for other window managers.

	-- window : 	a toplevel GdkWindow
	-- edge : 	the edge or corner from which the drag is started
	-- button : 	the button being used to drag
	-- root_x : 	root window X coordinate of mouse click that began the drag
	-- root_y : 	root window Y coordinate of mouse click that began the drag
	-- timestamp : 	timestamp of mouse click that began the drag (use gdk_event_get_time())
	-- gdk_window_begin_move_drag ()

	-- void        gdk_window_begin_move_drag      (GdkWindow *window,
	--                                              gint button,
	--                                              gint root_x,
	--                                              gint root_y,
	--                                              guint32 timestamp);

	-- Begins a window move operation (for a toplevel window). You might use this function to implement a "window move grip," for example. The function works best with window managers that support the Extended Window Manager Hints, but has a fallback implementation for other window managers.

	-- window : 	a toplevel GdkWindow
	-- button : 	the button being used to drag
	-- root_x : 	root window X coordinate of mouse click that began the drag
	-- root_y : 	root window Y coordinate of mouse click that began the drag
	-- timestamp : 	timestamp of mouse click that began the drag
	-- gdk_window_constrain_size ()

	-- void        gdk_window_constrain_size       (GdkGeometry *geometry,
	--                                              guint flags,
	--                                              gint width,
	--                                              gint height,
	--                                              gint *new_width,
	--                                              gint *new_height);

	-- Constrains a desired width and height according to a set of geometry hints (such as minimum and maximum size).

	-- geometry : 	a GdkGeometry structure
	-- flags : 	a mask indicating what portions of geometry are set
	-- width : 	desired width of window
	-- height : 	desired height of the window
	-- new_width : 	location to store resulting width
	-- new_height : 	location to store resulting height
	-- gdk_window_begin_paint_rect ()

	-- void        gdk_window_begin_paint_rect     (GdkWindow *window,
	--                                              GdkRectangle *rectangle);

	-- A convenience wrapper around gdk_window_begin_paint_region() which creates a rectangular region for you. See gdk_window_begin_paint_region() for details.

	-- window : 	a GdkWindow
	-- rectangle : 	rectangle you intend to draw to
	-- gdk_window_begin_paint_region ()

	-- void        gdk_window_begin_paint_region   (GdkWindow *window,
	--                                              GdkRegion *region);

	-- Indicates that you are beginning the process of redrawing region. A backing store (offscreen buffer) large enough to contain region will be created. The backing store will be initialized with the background color or background pixmap for window. Then, all drawing operations performed on window will be diverted to the backing store. When you call gdk_window_end_paint(), the backing store will be copied to window, making it visible onscreen. Only the part of window contained in region will be modified; that is, drawing operations are clipped to region.

	-- The net result of all this is to remove flicker, because the user sees the finished product appear all at once when you call gdk_window_end_paint(). If you draw to window directly without calling gdk_window_begin_paint_region(), the user may see flicker as individual drawing operations are performed in sequence. The clipping and background-initializing features of gdk_window_begin_paint_region() are conveniences for the programmer, so you can avoid doing that work yourself.

	-- When using GTK+, the widget system automatically places calls to gdk_window_begin_paint_region() and gdk_window_end_paint() around emissions of the expose_event signal. That is, if you're writing an expose event handler, you can assume that the exposed area in GdkEventExpose has already been cleared to the window background, is already set as the clip region, and already has a backing store. Therefore in most cases, application code need not call gdk_window_begin_paint_region(). (You can disable the automatic calls around expose events on a widget-by-widget basis by calling gtk_widget_set_double_buffered().)

	-- If you call this function multiple times before calling the matching gdk_window_end_paint(), the backing stores are pushed onto a stack. gdk_window_end_paint() copies the topmost backing store onscreen, subtracts the topmost region from all other regions in the stack, and pops the stack. All drawing operations affect only the topmost backing store in the stack. One matching call to gdk_window_end_paint() is required for each call to gdk_window_begin_paint_region().

	-- window : 	a GdkWindow
	-- region : 	region you intend to draw to
	-- gdk_window_end_paint ()

	-- void        gdk_window_end_paint            (GdkWindow *window);

	-- Indicates that the backing store created by the most recent call to gdk_window_begin_paint_region() should be copied onscreen and deleted, leaving the next-most-recent backing store or no backing store at all as the active paint region. See gdk_window_begin_paint_region() for full details. It is an error to call this function without a matching gdk_window_begin_paint_region() first.

	-- window : 	a GdkWindow
	-- gdk_window_invalidate_rect ()

	-- void        gdk_window_invalidate_rect      (GdkWindow *window,
	--                                              GdkRectangle *rect,
	--                                              gboolean invalidate_children);

	-- A convenience wrapper around gdk_window_invalidate_region() which invalidates a rectangular region. See gdk_window_invalidate_region() for details.

	-- window : 	a GdkWindow
	-- rect : 	rectangle to invalidate
	-- invalidate_children : 	whether to also invalidate child windows
	-- gdk_window_invalidate_region ()

	-- void        gdk_window_invalidate_region    (GdkWindow *window,
	--                                              GdkRegion *region,
	--                                              gboolean invalidate_children);

	-- Adds region to the update area for window. The update area is the region that needs to be redrawn, or "dirty region." The call gdk_window_process_updates() sends one or more expose events to the window, which together cover the entire update area. An application would normally redraw the contents of window in response to those expose events.

	-- GDK will call gdk_window_process_all_updates() on your behalf whenever your program returns to the main loop and becomes idle, so normally there's no need to do that manually, you just need to invalidate regions that you know should be redrawn.

	-- The invalidate_children parameter controls whether the region of each child window that intersects region will also be invalidated. If FALSE, then the update area for child windows will remain unaffected. See gdk_window_invalidate_maybe_recurse if you need fine grained control over which children are invalidated.

	-- window : 	a GdkWindow
	-- region : 	a GdkRegion
	-- invalidate_children : 	TRUE to also invalidate child windows
	-- gdk_window_invalidate_maybe_recurse ()

	-- void        gdk_window_invalidate_maybe_recurse
	--                                             (GdkWindow *window,
	--                                              GdkRegion *region,
	--                                              gboolean (*child_func) (GdkWindow *, gpointer),
	--                                              gpointer user_data);

	-- Adds region to the update area for window. The update area is the region that needs to be redrawn, or "dirty region." The call gdk_window_process_updates() sends one or more expose events to the window, which together cover the entire update area. An application would normally redraw the contents of window in response to those expose events.

	-- GDK will call gdk_window_process_all_updates() on your behalf whenever your program returns to the main loop and becomes idle, so normally there's no need to do that manually, you just need to invalidate regions that you know should be redrawn.

	-- The child_func parameter controls whether the region of each child window that intersects region will also be invalidated. Only children for which child_func returns TRUE will have the area invalidated.

	-- window : 	a GdkWindow
	-- region : 	a GdkRegion
	-- child_func : 	function to use to decide if to recurse to a child, NULL means never recurse.
	-- user_data : 	data passed to child_func
	-- gdk_window_get_update_area ()

	-- GdkRegion*  gdk_window_get_update_area      (GdkWindow *window);

	-- Transfers ownership of the update area from window to the caller of the function. That is, after calling this function, window will no longer have an invalid/dirty region; the update area is removed from window and handed to you. If a window has no update area, gdk_window_get_update_area() returns NULL. You are responsible for calling gdk_region_destroy() on the returned region if it's non-NULL.

	-- window : 	a GdkWindow
	-- Returns : 	the update area for window
	-- gdk_window_freeze_updates ()

	-- void        gdk_window_freeze_updates       (GdkWindow *window);

	-- Temporarily freezes a window such that it won't receive expose events. The window will begin receiving expose events again when gdk_window_thaw_updates() is called. If gdk_window_freeze_updates() has been called more than once, gdk_window_thaw_updates() must be called an equal number of times to begin processing exposes.

	-- window : 	a GdkWindow
	-- gdk_window_thaw_updates ()

	-- void        gdk_window_thaw_updates         (GdkWindow *window);

	-- Thaws a window frozen with gdk_window_freeze_updates().

	-- window : 	a GdkWindow
	-- gdk_window_process_all_updates ()

	-- void        gdk_window_process_all_updates  (void);

	-- Calls gdk_window_process_updates() for all windows (see GdkWindow) in the application.

	-- gdk_window_process_updates ()

	-- void        gdk_window_process_updates      (GdkWindow *window,
	--                                              gboolean update_children);

	-- Sends one or more expose events to window. The areas in each expose event will cover the entire update area for the window (see gdk_window_invalidate_region() for details). Normally GDK calls gdk_window_process_all_updates() on your behalf, so there's no need to call this function unless you want to force expose events to be delivered immediately and synchronously (vs. the usual case, where GDK delivers them in an idle handler). Occasionally this is useful to produce nicer scrolling behavior, for example.

	-- window : 	a GdkWindow
	-- update_children : 	whether to also process updates for child windows
	-- gdk_window_set_debug_updates ()

	-- void        gdk_window_set_debug_updates    (gboolean setting);

	-- With update debugging enabled, calls to gdk_window_invalidate_region() clear the invalidated region of the screen to a noticeable color, and GDK pauses for a short time before sending exposes to windows during gdk_window_process_updates(). The net effect is that you can see the invalid region for each window and watch redraws as they occur. This allows you to diagnose inefficiencies in your application.

	-- In essence, because the GDK rendering model prevents all flicker, if you are redrawing the same region 400 times you may never notice, aside from noticing a speed problem. Enabling update debugging causes GTK to flicker slowly and noticeably, so you can see exactly what's being redrawn when, in what order.

	-- The --gtk-debug=updates command line option passed to GTK+ programs enables this debug option at application startup time. That's usually more useful than calling gdk_window_set_debug_updates() yourself, though you might want to use this function to enable updates sometime after application startup time.

	-- setting : 	TRUE to turn on update debugging
	-- gdk_window_get_internal_paint_info ()

	-- void        gdk_window_get_internal_paint_info
	--                                             (GdkWindow *window,
	--                                              GdkDrawable **real_drawable,
	--                                              gint *x_offset,
	--                                              gint *y_offset);

	-- If you bypass the GDK layer and use windowing system primitives to draw directly onto a GdkWindow, then you need to deal with two details: there may be an offset between GDK coordinates and windowing system coordinates, and GDK may have redirected drawing to a offscreen pixmap as the result of a gdk_window_begin_paint_region() calls. This function allows retrieving the information you need to compensate for these effects.

	-- This function exposes details of the GDK implementation, and is thus likely to change in future releases of GDK.

	-- window : 	a GdkWindow
	-- real_drawable : 	location to store the drawable to which drawing should be done.
	-- x_offset : 	location to store the X offset between coordinates in window, and the underlying window system primitive coordinates for *real_drawable.
	-- y_offset : 	location to store the Y offset between coordinates in window, and the underlying window system primitive coordinates for *real_drawable.
	-- gdk_window_enable_synchronized_configure ()

	-- void        gdk_window_enable_synchronized_configure
	--                                             (GdkWindow *window);

	-- Indicates that the application will cooperate with the window system in synchronizing the window repaint with the window manager during resizing operations. After an application calls this function, it must call gdk_window_configure_finished() every time it has finished all processing associated with a set of Configure events. Toplevel GTK+ windows automatically use this protocol.

	-- On X, calling this function makes window participate in the _NET_WM_SYNC_REQUEST window manager protocol.

	-- window : 	a toplevel GdkWindow

	-- Since 2.6
	-- gdk_window_configure_finished ()

	-- void        gdk_window_configure_finished   (GdkWindow *window);

	-- Signal to the window system that the application has finished handling Configure events it has received. Window Managers can use this to better synchronize the frame repaint with the application. GTK+ applications will automatically call this function when appropriate.

	-- This function can only be called if gdk_window_enable_synchronized_configure() was called previously.

	-- window : 	a toplevel GdkWindow

	-- Since 2.6
	-- gdk_window_set_user_data ()

	-- void        gdk_window_set_user_data        (GdkWindow *window,
	--                                              gpointer user_data);

	-- For most purposes this function is deprecated in favor of g_object_set_data(). However, for historical reasons GTK+ stores the GtkWidget that owns a GdkWindow as user data on the GdkWindow. So, custom widget implementations should use this function for that. If GTK+ receives an event for a GdkWindow, and the user data for the window is non-NULL, GTK+ will assume the user data is a GtkWidget, and forward the event to that widget.

	-- window : 	a GdkWindow
	-- user_data : 	user data
	-- gdk_window_set_override_redirect ()

	-- void        gdk_window_set_override_redirect
	--                                             (GdkWindow *window,
	--                                              gboolean override_redirect);

	-- An override redirect window is not under the control of the window manager. This means it won't have a titlebar, won't be minimizable, etc. - it will be entirely under the control of the application. The window manager can't see the override redirect window at all.

	-- Override redirect should only be used for short-lived temporary windows, such as popup menus. GtkMenu uses an override redirect window in its implementation, for example.

	-- window : 	a toplevel GdkWindow
	-- override_redirect : 	TRUE if window should be override redirect
	-- gdk_window_set_accept_focus ()

	-- void        gdk_window_set_accept_focus     (GdkWindow *window,
	--                                              gboolean accept_focus);

	-- Setting accept_focus to FALSE hints the desktop environment that the window doesn't want to receive input focus.

	-- On X, it is the responsibility of the window manager to interpret this hint. ICCCM-compliant window manager usually respect it.

	-- window : 	a toplevel GdkWindow
	-- accept_focus : 	TRUE if the window should receive input focus

	-- Since 2.4
	-- gdk_window_set_focus_on_map ()

	-- void        gdk_window_set_focus_on_map     (GdkWindow *window,
	--                                              gboolean focus_on_map);

	-- Setting focus_on_map to FALSE hints the desktop environment that the window doesn't want to receive input focus when it is mapped. focus_on_map should be turned off for windows that aren't triggered interactively (such as popups from network activity).

	-- On X, it is the responsibility of the window manager to interpret this hint. Window managers following the freedesktop.org window manager extension specification should respect it.

	-- window : 	a toplevel GdkWindow
	-- focus_on_map : 	TRUE if the window should receive input focus when mapped

	-- Since 2.6
	-- gdk_window_add_filter ()

	-- void        gdk_window_add_filter           (GdkWindow *window,
	--                                              GdkFilterFunc function,
	--                                              gpointer data);

	-- Adds an event filter to window, allowing you to intercept events before they reach GDK. This is a low-level operation and makes it easy to break GDK and/or GTK+, so you have to know what you're doing. Pass NULL for window to get all events for all windows, instead of events for a specific window.

	-- window : 	a GdkWindow
	-- function : 	filter callback
	-- data : 	data to pass to filter callback
	-- gdk_window_remove_filter ()

	-- void        gdk_window_remove_filter        (GdkWindow *window,
	--                                              GdkFilterFunc function,
	--                                              gpointer data);

	-- Remove a filter previously added with gdk_window_add_filter().

	-- window : 	a GdkWindow
	-- function : 	previously-added filter function
	-- data : 	user data for previously-added filter function
	-- GdkFilterFunc ()

	-- GdkFilterReturn (*GdkFilterFunc)            (GdkXEvent *xevent,
	--                                              GdkEvent *event,
	--                                              gpointer data);

	-- Specifies the type of function used to filter native events before they are converted to GDK events.

	-- When a filter is called, event is unpopulated, except for event->window. The filter may translate the native event to a GDK event and store the result in event, or handle it without translation. If the filter translates the event and processing should continue, it should return GDK_FILTER_TRANSLATE.
	-- xevent : 	the native event to filter.
	-- event : 	the GDK event to which the X event will be translated.
	-- data : 	user data set when the filter was installed.
	-- Returns : 	a GdkFilterReturn value.
	-- enum GdkFilterReturn

	-- typedef enum {
	--   GDK_FILTER_CONTINUE,	  /* Event not handled, continue processesing */
	--   GDK_FILTER_TRANSLATE,	  /* Native event translated into a GDK event and
	--                              stored in the "event" structure that was
	--                              passed in */
	--   GDK_FILTER_REMOVE	  /* Terminate processing, removing event */
	-- } GdkFilterReturn;

	-- Specifies the result of applying a GdkFilterFunc to a native event.
	-- GDK_FILTER_CONTINUE 	event not handled, continue processing.
	-- GDK_FILTER_TRANSLATE 	native event translated into a GDK event and stored in the event structure that was passed in.
	-- GDK_FILTER_REMOVE 	event handled, terminate processing.
	-- GdkXEvent

	-- typedef void GdkXEvent;	  /* Can be cast to window system specific

	-- Used to represent native events (XEvents for the X11 backend, MSGs for Win32).
	-- gdk_window_shape_combine_mask ()

	-- void        gdk_window_shape_combine_mask   (GdkWindow *window,
	--                                              GdkBitmap *mask,
	--                                              gint x,
	--                                              gint y);

	-- Applies a shape mask to window. Pixels in window corresponding to set bits in the mask will be visible; pixels in window corresponding to unset bits in the mask will be transparent. This gives a non-rectangular window.

	-- If mask is NULL, the shape mask will be unset, and the x/y parameters are not used.

	-- On the X11 platform, this uses an X server extension which is widely available on most common platforms, but not available on very old X servers, and occasionally the implementation will be buggy. On servers without the shape extension, this function will do nothing.

	-- This function works on both toplevel and child windows.

	-- window : 	a GdkWindow
	-- mask : 	shape mask
	-- x : 	X position of shape mask with respect to window
	-- y : 	Y position of shape mask with respect to window
	-- gdk_window_shape_combine_region ()

	-- void        gdk_window_shape_combine_region (GdkWindow *window,
	--                                              GdkRegion *shape_region,
	--                                              gint offset_x,
	--                                              gint offset_y);

	-- Makes pixels in window outside shape_region be transparent, so that the window may be nonrectangular. See also gdk_window_shape_combine_mask() to use a bitmap as the mask.

	-- If shape_region is NULL, the shape will be unset, so the whole window will be opaque again. offset_x and offset_y are ignored if shape_region is NULL.

	-- On the X11 platform, this uses an X server extension which is widely available on most common platforms, but not available on very old X servers, and occasionally the implementation will be buggy. On servers without the shape extension, this function will do nothing.

	-- This function works on both toplevel and child windows.

	-- window : 	a GdkWindow
	-- shape_region : 	region of window to be non-transparent
	-- offset_x : 	X position of shape_region in window coordinates
	-- offset_y : 	Y position of shape_region in window coordinates
	-- gdk_window_set_child_shapes ()

	-- void        gdk_window_set_child_shapes     (GdkWindow *window);

	-- Sets the shape mask of window to the union of shape masks for all children of window, ignoring the shape mask of window itself. Contrast with gdk_window_merge_child_shapes() which includes the shape mask of window in the masks to be merged.

	-- window : 	a GdkWindow
	-- gdk_window_merge_child_shapes ()

	-- void        gdk_window_merge_child_shapes   (GdkWindow *window);

	-- Merges the shape masks for any child windows into the shape mask for window. i.e. the union of all masks for window and its children will become the new mask for window. See gdk_window_shape_combine_mask().

	-- This function is distinct from gdk_window_set_child_shapes() because it includes window's shape mask in the set of shapes to be merged.

	-- window : 	a GdkWindow
	-- gdk_window_set_static_gravities ()

	-- gboolean    gdk_window_set_static_gravities (GdkWindow *window,
	--                                              gboolean use_static);

	-- Set the bit gravity of the given window to static, and flag it so all children get static subwindow gravity. This is used if you are implementing scary features that involve deep knowledge of the windowing system. Don't worry about it unless you have to.

	-- window : 	a GdkWindow
	-- use_static : 	TRUE to turn on static gravity
	-- Returns : 	TRUE if the server supports static gravity
	-- gdk_window_set_hints ()

	-- void        gdk_window_set_hints            (GdkWindow *window,
	--                                              gint x,
	--                                              gint y,
	--                                              gint min_width,
	--                                              gint min_height,
	--                                              gint max_width,
	--                                              gint max_height,
	--                                              gint flags);

	-- Warning

	-- gdk_window_set_hints is deprecated and should not be used in newly-written code.

	-- This function is broken and useless and you should ignore it. If using GTK+, use functions such as gtk_window_resize(), gtk_window_set_size_request(), gtk_window_move(), gtk_window_parse_geometry(), and gtk_window_set_geometry_hints(), depending on what you're trying to do.

	-- If using GDK directly, use gdk_window_set_geometry_hints().

	-- window : 	a GdkWindow
	-- x : 	ignored field, does not matter
	-- y : 	ignored field, does not matter
	-- min_width : 	minimum width hint
	-- min_height : 	minimum height hint
	-- max_width : 	max width hint
	-- max_height : 	max height hint
	-- flags : 	logical OR of GDK_HINT_POS, GDK_HINT_MIN_SIZE, and/or GDK_HINT_MAX_SIZE
	-- gdk_window_set_title ()

	-- void        gdk_window_set_title            (GdkWindow *window,
	--                                              const gchar *title);

	-- Sets the title of a toplevel window, to be displayed in the titlebar. If you haven't explicitly set the icon name for the window (using gdk_window_set_icon_name()), the icon name will be set to title as well. title must be in UTF-8 encoding (as with all user-readable strings in GDK/GTK+). title may not be NULL.

	-- window : 	a toplevel GdkWindow
	-- title : 	title of window
	-- gdk_window_set_background ()

	-- void        gdk_window_set_background       (GdkWindow *window,
	--                                              const GdkColor *color);

	-- Sets the background color of window. (However, when using GTK+, set the background of a widget with gtk_widget_modify_bg() - if you're an application - or gtk_style_set_background() - if you're implementing a custom widget.)

	-- The color must be allocated; gdk_rgb_find_color() is the best way to allocate a color.

	-- See also gdk_window_set_back_pixmap().

	-- window : 	a GdkWindow
	-- color : 	an allocated GdkColor
	-- gdk_window_set_back_pixmap ()

	-- void        gdk_window_set_back_pixmap      (GdkWindow *window,
	--                                              GdkPixmap *pixmap,
	--                                              gboolean parent_relative);

	-- Sets the background pixmap of window. May also be used to set a background of "None" on window, by setting a background pixmap of NULL. A background pixmap will be tiled, positioning the first tile at the origin of window, or if parent_relative is TRUE, the tiling will be done based on the origin of the parent window (useful to align tiles in a parent with tiles in a child).

	-- A background pixmap of NULL means that the window will have no background. A window with no background will never have its background filled by the windowing system, instead the window will contain whatever pixels were already in the corresponding area of the display.

	-- The windowing system will normally fill a window with its background when the window is obscured then exposed, and when you call gdk_window_clear().

	-- window : 	a GdkWindow
	-- pixmap : 	a GdkPixmap, or NULL
	-- parent_relative : 	whether the tiling origin is at the origin of window's parent
	-- GDK_PARENT_RELATIVE

	-- #define GDK_PARENT_RELATIVE  1L

	-- A special value for GdkPixmap* variables, indicating that the background pixmap for a window should be inherited from the parent window.
	-- gdk_window_set_cursor ()

	-- void        gdk_window_set_cursor           (GdkWindow *window,
	--                                              GdkCursor *cursor);

	-- Sets the mouse pointer for a GdkWindow. Use gdk_cursor_new() or gdk_cursor_new_from_pixmap() to create the cursor. To make the cursor invisible, use gdk_cursor_new_from_pixmap() to create a cursor with no pixels in it. Passing NULL for the cursor argument to gdk_window_set_cursor() means that window will use the cursor of its parent window. Most windows should use this default.

	-- window : 	a GdkWindow
	-- cursor : 	a cursor
	-- gdk_window_set_colormap

	-- #define gdk_window_set_colormap        gdk_drawable_set_colormap

	-- Warning

	-- gdk_window_set_colormap is deprecated and should not be used in newly-written code.

	-- Deprecated equivalent to gdk_drawable_set_colormap()
	-- gdk_window_get_user_data ()

	-- void        gdk_window_get_user_data        (GdkWindow *window,
	--                                              gpointer *data);

	-- Retrieves the user data for window, which is normally the widget that window belongs to. See gdk_window_set_user_data().

	-- window : 	a GdkWindow
	-- data : 	return location for user data
	-- gdk_window_get_geometry ()

	-- void        gdk_window_get_geometry         (GdkWindow *window,
	--                                              gint *x,
	--                                              gint *y,
	--                                              gint *width,
	--                                              gint *height,
	--                                              gint *depth);

	-- Any of the return location arguments to this function may be NULL, if you aren't interested in getting the value of that field.

	-- The X and Y coordinates returned are relative to the parent window of window, which for toplevels usually means relative to the window decorations (titlebar, etc.) rather than relative to the root window (screen-size background window).

	-- On the X11 platform, the geometry is obtained from the X server, so reflects the latest position of window; this may be out-of-sync with the position of window delivered in the most-recently-processed GdkEventConfigure. gdk_window_get_position() in contrast gets the position from the most recent configure event.

	-- Note
	-- If window is not a toplevel, it is much better to call gdk_window_get_position() and gdk_drawable_get_size() instead, because it avoids the roundtrip to the X server and because gdk_drawable_get_size() supports the full 32-bit coordinate space, whereas gdk_window_get_geometry() is restricted to the 16-bit coordinates of X11.

	-- window : 	a GdkWindow
	-- x : 	return location for X coordinate of window (relative to its parent)
	-- y : 	return location for Y coordinate of window (relative to its parent)
	-- width : 	return location for width of window
	-- height : 	return location for height of window
	-- depth : 	return location for bit depth of window
	-- gdk_window_set_geometry_hints ()

	-- void        gdk_window_set_geometry_hints   (GdkWindow *window,
	--                                              GdkGeometry *geometry,
	--                                              GdkWindowHints geom_mask);

	-- Sets the geometry hints for window. Hints flagged in geom_mask are set, hints not flagged in geom_mask are unset. To unset all hints, use a geom_mask of 0 and a geometry of NULL.

	-- This function provides hints to the windowing system about acceptable sizes for a toplevel window. The purpose of this is to constrain user resizing, but the windowing system will typically (but is not required to) also constrain the current size of the window to the provided values and constrain programatic resizing via gdk_window_resize() or gdk_window_move_resize().

	-- Note that on X11, this effect has no effect on windows of type GDK_WINDOW_TEMP or windows where override redirect has been turned on via gdk_window_set_override_redirect() since these windows are not resizable by the user.

	-- Since you can't count on the windowing system doing the constraints for programmatic resizes, you should generally call gdk_window_constrain_size() yourself to determine appropriate sizes.

	-- window : 	a toplevel GdkWindow
	-- geometry : 	geometry hints
	-- geom_mask : 	bitmask indicating fields of geometry to pay attention to
	-- gdk_window_set_icon_list ()

	-- void        gdk_window_set_icon_list        (GdkWindow *window,
	--                                              GList *pixbufs);

	-- Sets a list of icons for the window. One of these will be used to represent the window when it has been iconified. The icon is usually shown in an icon box or some sort of task bar. Which icon size is shown depends on the window manager. The window manager can scale the icon but setting several size icons can give better image quality since the window manager may only need to scale the icon by a small amount or not at all.

	-- window : 	The GdkWindow toplevel window to set the icon of.
	-- pixbufs : 	A list of pixbufs, of different sizes.
	-- gdk_window_set_modal_hint ()

	-- void        gdk_window_set_modal_hint       (GdkWindow *window,
	--                                              gboolean modal);

	-- The application can use this hint to tell the window manager that a certain window has modal behaviour. The window manager can use this information to handle modal windows in a special way.

	-- You should only use this on windows for which you have previously called gdk_window_set_transient_for()

	-- window : 	A toplevel GdkWindow
	-- modal : 	TRUE if the window is modal, FALSE otherwise.
	-- gdk_window_set_type_hint ()

	-- void        gdk_window_set_type_hint        (GdkWindow *window,
	--                                              GdkWindowTypeHint hint);

	-- The application can use this call to provide a hint to the window manager about the functionality of a window. The window manager can use this information when determining the decoration and behaviour of the window.

	-- The hint must be set before the window is mapped.

	-- window : 	A toplevel GdkWindow
	-- hint : 	A hint of the function this window will have
	-- gdk_window_set_skip_taskbar_hint ()

	-- void        gdk_window_set_skip_taskbar_hint
	--                                             (GdkWindow *window,
	--                                              gboolean skips_taskbar);

	-- Toggles whether a window should appear in a task list or window list. If a window's semantic type as specified with gdk_window_set_type_hint() already fully describes the window, this function should not be called in addition, instead you should allow the window to be treated according to standard policy for its semantic type.

	-- window : 	a toplevel GdkWindow
	-- skips_taskbar : 	TRUE to skip the taskbar

	-- Since 2.2
	-- gdk_window_set_skip_pager_hint ()

	-- void        gdk_window_set_skip_pager_hint  (GdkWindow *window,
	--                                              gboolean skips_pager);

	-- Toggles whether a window should appear in a pager (workspace switcher, or other desktop utility program that displays a small thumbnail representation of the windows on the desktop). If a window's semantic type as specified with gdk_window_set_type_hint() already fully describes the window, this function should not be called in addition, instead you should allow the window to be treated according to standard policy for its semantic type.

	-- window : 	a toplevel GdkWindow
	-- skips_pager : 	TRUE to skip the pager

	-- Since 2.2
	-- gdk_window_set_urgency_hint ()

	-- void        gdk_window_set_urgency_hint     (GdkWindow *window,
	--                                              gboolean urgent);

	-- Toggles whether a window needs the user's urgent attention.

	-- window : 	a toplevel GdkWindow
	-- urgent : 	TRUE if the window is urgent

	-- Since 2.8

	position: TUPLE [INTEGER, INTEGER] is
			-- Obtains the position of the window as reported in the
			-- most-recently-processed GdkEventConfigure. Contrast with
			-- `geometry' which queries the X server for the current window
			-- position, regardless of which events have been received or
			-- processed.
			--
			-- The position coordinates are relative to the window's parent
			-- window.
		local
			an_x, an_y: INTEGER
		do
			gdk_window_get_position (handle, $an_x, $an_y)
			Result := [an_x, an_y]
		end

	-- gdk_window_get_root_origin ()

	-- void        gdk_window_get_root_origin      (GdkWindow *window,
	--                                              gint *x,
	--                                              gint *y);

	-- Obtains the top-left corner of the window manager frame in root window coordinates.

	-- window : 	a toplevel GdkWindow
	-- x : 	return location for X position of window frame
	-- y : 	return location for Y position of window frame
	-- gdk_window_get_frame_extents ()

	-- void        gdk_window_get_frame_extents    (GdkWindow *window,
	--                                              GdkRectangle *rect);

	-- Obtains the bounding box of the window, including window manager titlebar/borders if any. The frame position is given in root window coordinates. To get the position of the window itself (rather than the frame) in root window coordinates, use gdk_window_get_origin().

	-- window : 	a toplevel GdkWindow
	-- rect : 	rectangle to fill with bounding box of the window frame
	-- gdk_window_get_size

	-- #define gdk_window_get_size            gdk_drawable_get_size

	-- Warning

	-- gdk_window_get_size is deprecated and should not be used in newly-written code.

	-- Deprecated equivalent of gdk_drawable_get_size().
	-- gdk_window_get_visual

	-- #define gdk_window_get_visual          gdk_drawable_get_visual

	-- Warning

	-- gdk_window_get_visual is deprecated and should not be used in newly-written code.

	-- Deprecated equivalent of gdk_drawable_get_visual().
	-- Returns : 	the GdkVisual of the window
	-- gdk_window_get_colormap

	-- #define gdk_window_get_colormap        gdk_drawable_get_colormap

	-- Warning

	-- gdk_window_get_colormap is deprecated and should not be used in newly-written code.

	-- Deprecated equivalent of gdk_drawable_get_colormap().
	-- Returns : 	colormap for the window
	-- gdk_window_get_type

	-- #define gdk_window_get_type            gdk_window_get_window_type

	-- Warning

	-- gdk_window_get_type is deprecated and should not be used in newly-written code.

	-- Deprecated equivalent of gdk_drawable_get_type().
	-- Returns : 	type of drawable
	-- gdk_window_get_origin ()

	-- gint        gdk_window_get_origin           (GdkWindow *window,
	--                                              gint *x,
	--                                              gint *y);

	-- Obtains the position of a window in root window coordinates. (Compare with gdk_window_get_position() and gdk_window_get_geometry() which return the position of a window relative to its parent window.)

	-- window : 	a GdkWindow
	-- x : 	return location for X coordinate
	-- y : 	return location for Y coordinate
	-- Returns : 	not meaningful, ignore
	-- gdk_window_get_deskrelative_origin ()

	-- gboolean    gdk_window_get_deskrelative_origin
	--                                             (GdkWindow *window,
	--                                              gint *x,
	--                                              gint *y);

	-- Warning

	-- gdk_window_get_deskrelative_origin is deprecated and should not be used in newly-written code.

	-- This gets the origin of a GdkWindow relative to an Enlightenment-window-manager desktop. As long as you don't assume that the user's desktop/workspace covers the entire root window (i.e. you don't assume that the desktop begins at root window coordinate 0,0) this function is not necessary. It's deprecated for that reason.

	-- window : 	a toplevel GdkWindow
	-- x : 	return location for X coordinate
	-- y : 	return location for Y coordinate
	-- Returns : 	not meaningful
	-- gdk_window_get_pointer ()

	-- GdkWindow*  gdk_window_get_pointer          (GdkWindow *window,
	--                                              gint *x,
	--                                              gint *y,
	--                                              GdkModifierType *mask);

	-- Obtains the current pointer position and modifier state. The position is given in coordinates relative to window.

	-- window : 	a GdkWindow
	-- x : 	return location for X coordinate of pointer
	-- y : 	return location for Y coordinate of pointer
	-- mask : 	return location for modifier mask
	-- Returns : 	the window containing the pointer (as with gdk_window_at_pointer()), or NULL if the window containing the pointer isn't known to GDK
	-- enum GdkModifierType

	-- typedef enum
	-- {
	--   GDK_SHIFT_MASK    = 1 < < 0,
	--   GDK_LOCK_MASK	    = 1 < < 1,
	--   GDK_CONTROL_MASK  = 1 < < 2,
	--   GDK_MOD1_MASK	    = 1 < < 3,
	--   GDK_MOD2_MASK	    = 1 < < 4,
	--   GDK_MOD3_MASK	    = 1 < < 5,
	--   GDK_MOD4_MASK	    = 1 < < 6,
	--   GDK_MOD5_MASK	    = 1 < < 7,
	--   GDK_BUTTON1_MASK  = 1 < < 8,
	--   GDK_BUTTON2_MASK  = 1 < < 9,
	--   GDK_BUTTON3_MASK  = 1 < < 10,
	--   GDK_BUTTON4_MASK  = 1 < < 11,
	--   GDK_BUTTON5_MASK  = 1 < < 12,
	--   /* The next few modifiers are used by XKB, so we skip to the end.
	--    * Bits 16 - 28 are currently unused, but will eventually
	--    * be used for "virtual modifiers". Bit 29 is used internally.
	--    */
	--   GDK_RELEASE_MASK  = 1 < < 30,
	--   GDK_MODIFIER_MASK = GDK_RELEASE_MASK | 0x1fff
	-- } GdkModifierType;

	-- A set of bit-flags to indicate the state of modifier keys and mouse buttons in various event types. Typical modifier keys are Shift, Control, Meta, Super, Hyper, Alt, Compose, Apple, CapsLock or ShiftLock.

	-- Like the X Window System, GDK supports 8 modifier keys and 5 mouse buttons.
	-- GDK_SHIFT_MASK 	the Shift key.
	-- GDK_LOCK_MASK 	a Lock key (depending on the modifier mapping of the X server this may either be CapsLock or ShiftLock).
	-- GDK_CONTROL_MASK 	the Control key.
	-- GDK_MOD1_MASK 	the fourth modifier key (it depends on the modifier mapping of the X server which key is interpreted as this modifier, but normally it is the Alt key).
	-- GDK_MOD2_MASK 	the fifth modifier key (it depends on the modifier mapping of the X server which key is interpreted as this modifier).
	-- GDK_MOD3_MASK 	the sixth modifier key (it depends on the modifier mapping of the X server which key is interpreted as this modifier).
	-- GDK_MOD4_MASK 	the seventh modifier key (it depends on the modifier mapping of the X server which key is interpreted as this modifier).
	-- GDK_MOD5_MASK 	the eighth modifier key (it depends on the modifier mapping of the X server which key is interpreted as this modifier).
	-- GDK_BUTTON1_MASK 	the first mouse button.
	-- GDK_BUTTON2_MASK 	the second mouse button.
	-- GDK_BUTTON3_MASK 	the third mouse button.
	-- GDK_BUTTON4_MASK 	the fourth mouse button.
	-- GDK_BUTTON5_MASK 	the fifth mouse button.
	-- GDK_RELEASE_MASK 	not used in GDK itself. GTK+ uses it to differentiate between (keyval, modifiers) pairs from key press and release events.
	-- GDK_MODIFIER_MASK 	a mask covering all modifier types.
	-- gdk_window_get_parent ()

	-- GdkWindow*  gdk_window_get_parent           (GdkWindow *window);

	-- Obtains the parent of window, as known to GDK. Does not query the X server; thus this returns the parent as passed to gdk_window_new(), not the actual parent. This should never matter unless you're using Xlib calls mixed with GDK calls on the X11 platform. It may also matter for toplevel windows, because the window manager may choose to reparent them.

	-- window : 	a GdkWindow
	-- Returns : 	parent of window
	-- gdk_window_get_toplevel ()

	-- GdkWindow*  gdk_window_get_toplevel         (GdkWindow *window);

	-- Gets the toplevel window that's an ancestor of window.

	-- window : 	a GdkWindow
	-- Returns : 	the toplevel window containing window
	-- gdk_window_get_children ()

	-- GList*      gdk_window_get_children         (GdkWindow *window);

	-- Gets the list of children of window known to GDK. This function only returns children created via GDK, so for example it's useless when used with the root window; it only returns windows an application created itself.

	-- The returned list must be freed, but the elements in the list need not be.

	-- window : 	a GdkWindow
	-- Returns : 	list of child windows inside window
	-- gdk_window_peek_children ()

	-- GList*      gdk_window_peek_children        (GdkWindow *window);

	-- Like gdk_window_get_children(), but does not copy the list of children, so the list does not need to be freed.

	-- window : 	a GdkWindow
	-- Returns : 	a reference to the list of child windows in window
	-- gdk_window_get_events ()

	-- GdkEventMask gdk_window_get_events          (GdkWindow *window);

	-- Gets the event mask for window. See gdk_window_set_events().

	-- window : 	a GdkWindow
	-- Returns : 	event mask for window
	-- gdk_window_set_events ()

	-- void        gdk_window_set_events           (GdkWindow *window,
	--                                              GdkEventMask event_mask);

	-- The event mask for a window determines which events will be reported for that window. For example, an event mask including GDK_BUTTON_PRESS_MASK means the window should report button press events. The event mask is the bitwise OR of values from the GdkEventMask enumeration.

	-- window : 	a GdkWindow
	-- event_mask : 	event mask for window
	-- gdk_window_set_icon ()

	-- void        gdk_window_set_icon             (GdkWindow *window,
	--                                              GdkWindow *icon_window,
	--                                              GdkPixmap *pixmap,
	--                                              GdkBitmap *mask);

	-- Sets the icon of window as a pixmap or window. If using GTK+, investigate gtk_window_set_default_icon_list() first, and then gtk_window_set_icon_list() and gtk_window_set_icon(). If those don't meet your needs, look at gdk_window_set_icon_list(). Only if all those are too high-level do you want to fall back to gdk_window_set_icon().

	-- window : 	a toplevel GdkWindow
	-- icon_window : 	a GdkWindow to use for the icon, or NULL to unset
	-- pixmap : 	a GdkPixmap to use as the icon, or NULL to unset
	-- mask : 	a 1-bit pixmap (GdkBitmap) to use as mask for pixmap, or NULL to have none
	-- gdk_window_set_icon_name ()

	-- void        gdk_window_set_icon_name        (GdkWindow *window,
	--                                              const gchar *name);

	-- Windows may have a name used while minimized, distinct from the name they display in their titlebar. Most of the time this is a bad idea from a user interface standpoint. But you can set such a name with this function, if you like.

	-- window : 	a toplevel GdkWindow
	-- name : 	name of window while iconified (minimized)
	-- gdk_window_set_transient_for ()

	-- void        gdk_window_set_transient_for    (GdkWindow *window,
	--                                              GdkWindow *parent);

	-- Indicates to the window manager that window is a transient dialog associated with the application window parent. This allows the window manager to do things like center window on parent and keep window above parent.

	-- See gtk_window_set_transient_for() if you're using GtkWindow or GtkDialog.

	-- window : 	a toplevel GdkWindow
	-- parent : 	another toplevel GdkWindow
	-- gdk_window_set_role ()

	-- void        gdk_window_set_role             (GdkWindow *window,
	--                                              const gchar *role);

	-- When using GTK+, typically you should use gtk_window_set_role() instead of this low-level function.

	-- The window manager and session manager use a window's role to distinguish it from other kinds of window in the same application. When an application is restarted after being saved in a previous session, all windows with the same title and role are treated as interchangeable. So if you have two windows with the same title that should be distinguished for session management purposes, you should set the role on those windows. It doesn't matter what string you use for the role, as long as you have a different role for each non-interchangeable kind of window.

	-- window : 	a toplevel GdkWindow
	-- role : 	a string indicating its role
	-- gdk_window_set_group ()

	-- void        gdk_window_set_group            (GdkWindow *window,
	--                                              GdkWindow *leader);

	-- Sets the group leader window for window. By default, GDK sets the group leader for all toplevel windows to a global window implicitly created by GDK. With this function you can override this default.

	-- The group leader window allows the window manager to distinguish all windows that belong to a single application. It may for example allow users to minimize/unminimize all windows belonging to an application at once. You should only set a non-default group window if your application pretends to be multiple applications.

	-- window : 	a toplevel GdkWindow
	-- leader : 	group leader window, or NULL to restore the default group leader window
	-- gdk_window_get_group ()

	-- GdkWindow*  gdk_window_get_group            (GdkWindow *window);

	-- Returns the group leader window for window. See gdk_window_set_group().

	-- window : 	a toplevel GdkWindow
	-- Returns : 	the group leader window for window

	-- Since 2.4
	-- gdk_window_set_decorations ()

	-- void        gdk_window_set_decorations      (GdkWindow *window,
	--                                              GdkWMDecoration decorations);

	-- "Decorations" are the features the window manager adds to a toplevel GdkWindow. This function sets the traditional Motif window manager hints that tell the window manager which decorations you would like your window to have. Usually you should use gtk_window_set_decorated() on a GtkWindow instead of using the GDK function directly.

	-- The decorations argument is the logical OR of the fields in the GdkWMDecoration enumeration. If GDK_DECOR_ALL is included in the mask, the other bits indicate which decorations should be turned off. If GDK_DECOR_ALL is not included, then the other bits indicate which decorations should be turned on.

	-- Most window managers honor a decorations hint of 0 to disable all decorations, but very few honor all possible combinations of bits.

	-- window : 	a toplevel GdkWindow
	-- decorations : 	decoration hint mask
	-- gdk_window_get_decorations ()

	-- gboolean    gdk_window_get_decorations      (GdkWindow *window,
	--                                              GdkWMDecoration *decorations);

	-- Returns the decorations set on the GdkWindow with gdk_window_set_decorations

	-- window : 	The toplevel GdkWindow to get the decorations from
	-- decorations : 	The window decorations will be written here
	-- Returns : 	TRUE if the window has decorations set, FALSE otherwise.
	-- enum GdkWMDecoration

	-- typedef enum
	-- {
	--   GDK_DECOR_ALL		= 1 < < 0,
	--   GDK_DECOR_BORDER	= 1 < < 1,
	--   GDK_DECOR_RESIZEH	= 1 < < 2,
	--   GDK_DECOR_TITLE	= 1 < < 3,
	--   GDK_DECOR_MENU	= 1 < < 4,
	--   GDK_DECOR_MINIMIZE	= 1 < < 5,
	--   GDK_DECOR_MAXIMIZE	= 1 < < 6
	-- } GdkWMDecoration;

	-- These are hints originally defined by the Motif toolkit. The window manager can use them when determining how to decorate the window. The hint must be set before mapping the window.
	-- GDK_DECOR_ALL 	all decorations should be applied.
	-- GDK_DECOR_BORDER 	a frame should be drawn around the window.
	-- GDK_DECOR_RESIZEH 	the frame should have resize handles.
	-- GDK_DECOR_TITLE 	a titlebar should be placed above the window.
	-- GDK_DECOR_MENU 	a button for opening a menu should be included.
	-- GDK_DECOR_MINIMIZE 	a minimize button should be included.
	-- GDK_DECOR_MAXIMIZE 	a maximize button should be included.
	-- gdk_window_set_functions ()

	-- void        gdk_window_set_functions        (GdkWindow *window,
	--                                              GdkWMFunction functions);

	-- This function isn't really good for much. It sets the traditional Motif window manager hint for which operations the window manager should allow on a toplevel window. However, few window managers do anything reliable or interesting with this hint. Many ignore it entirely.

	-- The functions argument is the logical OR of values from the GdkWMFunction enumeration. If the bitmask includes GDK_FUNC_ALL, then the other bits indicate which functions to disable; if it doesn't include GDK_FUNC_ALL, it indicates which functions to enable.

	-- window : 	a toplevel GdkWindow
	-- functions : 	bitmask of operations to allow on window
	-- enum GdkWMFunction

	-- typedef enum
	-- {
	--   GDK_FUNC_ALL		= 1 < < 0,
	--   GDK_FUNC_RESIZE	= 1 < < 1,
	--   GDK_FUNC_MOVE		= 1 < < 2,
	--   GDK_FUNC_MINIMIZE	= 1 < < 3,
	--   GDK_FUNC_MAXIMIZE	= 1 < < 4,
	--   GDK_FUNC_CLOSE	= 1 < < 5
	-- } GdkWMFunction;

	-- These are hints originally defined by the Motif toolkit. The window manager can use them when determining the functions to offer for the window. The hint must be set before mapping the window.
	-- GDK_FUNC_ALL 	all functions should be offered.
	-- GDK_FUNC_RESIZE 	the window should be resizable.
	-- GDK_FUNC_MOVE 	the window should be movable.
	-- GDK_FUNC_MINIMIZE 	the window should be minimizable.
	-- GDK_FUNC_MAXIMIZE 	the window should be maximizable.
	-- GDK_FUNC_CLOSE 	the window should be closable.
	-- gdk_window_get_toplevels ()

	-- GList*      gdk_window_get_toplevels        (void);

	-- Obtains a list of all toplevel windows known to GDK on the default screen (see gdk_window_get_toplevels_for_screen()). A toplevel window is a child of the root window (see gdk_get_default_root_window()).

	-- The returned list should be freed with g_list_free(), but its elements need not be freed.

	-- Returns : 	list of toplevel windows, free with g_list_free()
	-- gdk_get_default_root_window ()

	-- GdkWindow*  gdk_get_default_root_window     (void);

	-- Obtains the root window (parent all other windows are inside) for the default display and screen.

	-- Returns : 	the default root window
	-- GdkPointerHooks

	-- typedef struct {
	--   GdkWindow* (*get_pointer)       (GdkWindow	   *window,
	-- 			           gint	           *x,
	-- 			           gint   	   *y,
	-- 			           GdkModifierType *mask);
	--   GdkWindow* (*window_at_pointer) (GdkScreen       *screen, /* unused */
	--                                    gint            *win_x,
	--                                    gint            *win_y);
	-- } GdkPointerHooks;

	-- A table of pointers to functions for getting quantities related to the current pointer position. GDK has one global table of this type, which can be set using gdk_set_pointer_hooks().

	-- This is only useful for such low-level tools as an event recorder. Applications should never have any reason to use this facility
	-- get_pointer () 	Obtains the current pointer position and modifier state. The position is given in coordinates relative to the window containing the pointer, which is returned in window.
	-- window_at_pointer () 	Obtains the window underneath the mouse pointer, returning the location of that window in win_x, win_y. Returns NULL if the window under the mouse pointer is not known to GDK (for example, belongs to another application).
	-- gdk_set_pointer_hooks ()

	-- GdkPointerHooks* gdk_set_pointer_hooks      (const GdkPointerHooks *new_hooks);

	-- This function allows for hooking into the operation of getting the current location of the pointer. This is only useful for such low-level tools as an event recorder. Applications should never have any reason to use this facility.

	-- This function is not multihead safe. For multihead operation, see gdk_display_set_pointer_hooks().

	-- new_hooks : 	a table of pointers to functions for getting quantities related to the current pointer position, or NULL to restore the default table.
	-- Returns : 	the previous pointer hook table
end
