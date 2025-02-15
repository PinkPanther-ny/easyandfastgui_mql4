//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//+------------------------------------------------------------------+
//| Class for creating an application                                |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- Form
   CWindow           m_window;
   //--- Main menu and its context menus
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- Group of simple buttons 1
   CButtonsGroup     m_buttons_group1;
   //--- Group of radio buttons 1
   CRadioButtons     m_radio_buttons1;
   //--- Group of simple buttons 2
   CButtonsGroup     m_buttons_group2;
   //--- Groups of radio buttons 2,3,4
   CRadioButtons     m_radio_buttons2;
   CRadioButtons     m_radio_buttons3;
   CRadioButtons     m_radio_buttons4;
   //--- Group of icon buttons 1
   CIconButtonsGroup m_icon_buttons_group1;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- Initialization/deinitialization
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- Timer
   void              OnTimerEvent(void);
   //---
protected:
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
public:
   //--- Create an expert panel
   bool              CreateExpertPanel(void);
   //---
private:
   //--- Form
   bool              CreateWindow(const string text);
   //--- Main menu and its context menus
#define MENUBAR_GAP_X        (1)
#define MENUBAR_GAP_Y        (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- Group of simple buttons 1
#define BUTTONS_GROUP1_GAP_X     (7)
#define BUTTONS_GROUP1_GAP_Y     (50)
   bool              CreateButtonsGroup1(void);
   //--- Group of radio buttons 1
#define RADIO_BUTTONS1_GAP_X     (7)
#define RADIO_BUTTONS1_GAP_Y     (75)
   bool              CreateRadioButtons1();
   //--- Group of simple buttons 2
#define BUTTONS_GROUP2_GAP_X     (7)
#define BUTTONS_GROUP2_GAP_Y     (100)
   bool              CreateButtonsGroup2(void);
   //--- Groups of radio buttons 2,3,4
#define RADIO_BUTTONS2_GAP_X     (7)
#define RADIO_BUTTONS2_GAP_Y     (125)
   bool              CreateRadioButtons2();
#define RADIO_BUTTONS3_GAP_X     (105)
#define RADIO_BUTTONS3_GAP_Y     (125)
   bool              CreateRadioButtons3();
#define RADIO_BUTTONS4_GAP_X     (203)
#define RADIO_BUTTONS4_GAP_Y     (125)
   bool              CreateRadioButtons4();
   //--- Group of icon buttons 1
#define IBUTTONS_GROUP1_GAP_X    (7)
#define IBUTTONS_GROUP1_GAP_Y    (190)
   bool              CreateIconButtonsGroup1(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CProgram::~CProgram(void)
  {
  }
//+------------------------------------------------------------------+
//| Initialization                                                   |
//+------------------------------------------------------------------+
void CProgram::OnInitEvent(void)
  {
  }
//+------------------------------------------------------------------+
//| Uninitialization                                                 |
//+------------------------------------------------------------------+
void CProgram::OnDeinitEvent(const int reason)
  {
//--- Removing the interface
   CWndEvents::Destroy();
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTimerEvent(void)
  {
   CWndEvents::OnTimerEvent();
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- The text label press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
     {
      ::Print("id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      return;
     }
//--- Clicking on the menu item event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_CONTEXTMENU_ITEM)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      return;
     }
//--- The button press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      ::Print("id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      //--- If the identifier of the second group or simple buttons and 
      //    the text of selected button in this group match the string parameter of the message
      if(lparam==m_buttons_group2.Id() && sparam==m_buttons_group2.SelectedButtonText())
        {
         //--- If this is the index of the first button, unblock specified controls
         if((int)dparam==0)
           {
            m_buttons_group1.ButtonsGroupState(true);
            m_radio_buttons1.RadioButtonsState(true);
            m_icon_buttons_group1.IconButtonsState(true);
           }
         //--- If this is the index of the second button, block specified controls
         else
           {
            m_buttons_group1.ButtonsGroupState(false);
            m_radio_buttons1.RadioButtonsState(false);
            m_icon_buttons_group1.IconButtonsState(false);
           }
        }
      return;
     }
  }
//+------------------------------------------------------------------+
//| Create an expert panel                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(void)
  {
//--- Creating a form for controls
   if(!CreateWindow("EXPERT PANEL"))
      return(false);
//--- Creating controls:
//    Main menu
   if(!CreateMenuBar())
      return(false);
//--- Context menus
   if(!CreateMBContextMenu1())
      return(false);
   if(!CreateMBContextMenu2())
      return(false);
   if(!CreateMBContextMenu3())
      return(false);
   if(!CreateMBContextMenu4())
      return(false);
//--- Group of simple buttons 1
   if(!CreateButtonsGroup1())
      return(false);
//--- Group of radio buttons 1
   if(!CreateRadioButtons1())
      return(false);
//--- Group of simple buttons 2
   if(!CreateButtonsGroup2())
      return(false);
//--- Groups of radio buttons 2,3,4
   if(!CreateRadioButtons2())
      return(false);
   if(!CreateRadioButtons3())
      return(false);
   if(!CreateRadioButtons4())
      return(false);
//--- Group of icon buttons 1
   if(!CreateIconButtonsGroup1())
      return(false);
//--- Redrawing the chart
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a form for controls                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window);
//--- Coordinates
   int x=1;
   int y=20;
//--- Properties
   m_window.XSize(300);
   m_window.YSize(290);
   m_window.Movable(true);
   m_window.UseRollButton();
//--- Creating the form
   if(!m_window.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the main menu                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuBar(void)
  {
//--- Three items in the main menu
#define MENUBAR_TOTAL 3
//--- Store the window pointer
   m_menubar.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+MENUBAR_GAP_X;
   int y=m_window.Y()+MENUBAR_GAP_Y;
//--- Arrays with unique properties of each item
   int    width[MENUBAR_TOTAL] ={50,55,53};
   string text[MENUBAR_TOTAL]  ={"File","View","Help"};
//--- Set properties before creation
   m_menubar.AutoXResizeMode(true);
   m_menubar.AutoXResizeRightOffset(1);
//--- Add items to the main menu
   for(int i=0; i<MENUBAR_TOTAL; i++)
      m_menubar.AddItem(width[i],text[i]);
//--- Create control
   if(!m_menubar.CreateMenuBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menubar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
//---
bool CProgram::CreateMBContextMenu1(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS1 3
//--- Store the window pointer
   m_mb_contextmenu1.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mb_contextmenu1.PrevNodePointer(m_menubar.ItemPointerByIndex(0));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(0,m_mb_contextmenu1);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS1]=
     {
      "ContextMenu 1 Item 1",
      "ContextMenu 1 Item 2",
      "ContextMenu 1 Item 3..."
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE
     };
//--- Set properties before creation
   m_mb_contextmenu1.FixSide(FIX_BOTTOM);
   m_mb_contextmenu1.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS1; i++)
      m_mb_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu1.AddSeparateLine(1);
//--- Deactivate the second item
   m_mb_contextmenu1.ItemPointerByIndex(1).ItemState(false);
//--- Create a context menu
   if(!m_mb_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu2(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS2 3
//--- Store the window pointer
   m_mb_contextmenu2.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mb_contextmenu2.PrevNodePointer(m_menubar.ItemPointerByIndex(1));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(1,m_mb_contextmenu2);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS2]=
     {
      "ContextMenu 2 Item 1",
      "ContextMenu 2 Item 2",
      "ContextMenu 2 Item 3"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS2]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu2.FixSide(FIX_BOTTOM);
   m_mb_contextmenu2.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS2; i++)
      m_mb_contextmenu2.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu2.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mb_contextmenu2.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp"
//---
bool CProgram::CreateMBContextMenu3(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS3 5
//--- Store the window pointer
   m_mb_contextmenu3.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mb_contextmenu3.PrevNodePointer(m_menubar.ItemPointerByIndex(2));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(2,m_mb_contextmenu3);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS3]=
     {
      "ContextMenu 3 Item 1",
      "ContextMenu 3 Item 2",
      "ContextMenu 3 Item 3...",
      "ContextMenu 3 Item 4",
      "ContextMenu 3 Item 5"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp",
      "",""
     };
//--- Array of icon for the blocked mode 
   string items_bmp_off[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS3]=
     {
      MI_SIMPLE,
      MI_HAS_CONTEXT_MENU,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu3.FixSide(FIX_BOTTOM);
   m_mb_contextmenu3.XSize(160);
   m_mb_contextmenu3.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS3; i++)
      m_mb_contextmenu3.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the third item
   m_mb_contextmenu3.AddSeparateLine(2);
//--- Create a context menu
   if(!m_mb_contextmenu3.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu4(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS4 3
//--- Store the window pointer
   m_mb_contextmenu4.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mb_contextmenu4.PrevNodePointer(m_mb_contextmenu3.ItemPointerByIndex(1));
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS4]=
     {
      "ContextMenu 4 Item 1",
      "ContextMenu 4 Item 2",
      "ContextMenu 4 Item 3"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS4]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu4.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS4; i++)
      m_mb_contextmenu4.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu4.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mb_contextmenu4.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a group of simple buttons                                |
//+------------------------------------------------------------------+
bool CProgram::CreateButtonsGroup1(void)
  {
//--- Store the window pointer
   m_buttons_group1.WindowPointer(m_window);
//--- Coordinates
   int x =m_window.X()+BUTTONS_GROUP1_GAP_X;
   int y =m_window.Y()+BUTTONS_GROUP1_GAP_Y;
//--- Properties
   int    buttons_x_gap[]         ={0,72,144,216};
   string buttons_text[]          ={"BUTTON 1","BUTTON 2","BUTTON 3","BUTTON 4"};
   int    buttons_width[]         ={70,70,70,70};
   color  buttons_color[]         ={C'255,140,140',C'255,140,140',C'140,200,240',C'140,200,240'};
   color  buttons_color_hover[]   ={C'255,180,180',C'255,180,180',C'180,220,255',C'180,220,255'};
   color  buttons_color_pressed[] ={C'225,90,90',C'225,90,90',C'110,160,190',C'110,160,190'};
//--- Properties
   m_buttons_group1.TextColorPressed(clrGold);
//--- Add four buttons to a group
   for(int i=0; i<4; i++)
      m_buttons_group1.AddButton(buttons_x_gap[i],0,buttons_text[i],buttons_width[i],
                                 buttons_color[i],buttons_color_hover[i],buttons_color_pressed[i]);
//--- Create a group of buttons
   if(!m_buttons_group1.CreateButtonsGroup(m_chart_id,m_subwin,x,y))
      return(false);
//--- Highlight the second button in the group
   m_buttons_group1.SelectionButton(1);
//--- Block the buttons
   m_buttons_group1.ButtonsGroupState(false);   
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_buttons_group1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates group of radio buttons 1                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateRadioButtons1(void)
  {
//--- Store the window pointer
   m_radio_buttons1.WindowPointer(m_window);
//--- Coordinates
   int x =m_window.X()+RADIO_BUTTONS1_GAP_X;
   int y =m_window.Y()+RADIO_BUTTONS1_GAP_Y;
//--- Properties
   int    buttons_x_offset[] ={0,98,196};
   int    buttons_y_offset[] ={0,0,0};
   string buttons_text[]     ={"Radio Button 1","Radio Button 2","Radio Button 3"};
   int    buttons_width[]    ={92,92,92};
//--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_radio_buttons1.AddButton(buttons_x_offset[i],buttons_y_offset[i],buttons_text[i],buttons_width[i]);
//--- Create a group of buttons
   if(!m_radio_buttons1.CreateRadioButtons(m_chart_id,m_subwin,x,y))
      return(false);
//--- Highlight the second button in the group
   m_radio_buttons1.SelectionRadioButton(1);
//--- Block radio buttons
   m_radio_buttons1.RadioButtonsState(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_radio_buttons1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a group of simple buttons 2                              |
//+------------------------------------------------------------------+
bool CProgram::CreateButtonsGroup2(void)
  {
//--- Store the window pointer
   m_buttons_group2.WindowPointer(m_window);
//--- Coordinates
   int x  =m_window.X()+BUTTONS_GROUP2_GAP_X;
   int y  =m_window.Y()+BUTTONS_GROUP2_GAP_Y;
//--- Properties
   int    buttons_x_offset[] ={0,144};
   string buttons_text[]     ={"BUTTON 1","BUTTON 2"};
//--- set properties
   m_buttons_group2.RadioButtonsMode(true);
   m_buttons_group2.TextColorPressed(clrBlack);
//--- Add two buttons to the group
   for(int i=0; i<2; i++)
      m_buttons_group2.AddButton(buttons_x_offset[i],0,buttons_text[i],142,
                                 clrGainsboro,C'193,218,255',C'190,190,200');
//--- Create a group of buttons
   if(!m_buttons_group2.CreateButtonsGroup(m_chart_id,m_subwin,x,y))
      return(false);
//--- Highlight the second button in the group
   m_buttons_group2.SelectionButton(1);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_buttons_group2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates group of radio buttons 2                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateRadioButtons2(void)
  {
//--- Store the window pointer
   m_radio_buttons2.WindowPointer(m_window);
//--- Coordinates
   int x =m_window.X()+RADIO_BUTTONS2_GAP_X;
   int y =m_window.Y()+RADIO_BUTTONS2_GAP_Y;
//--- Properties
   int    buttons_x_offset[] ={0,0,0};
   int    buttons_y_offset[] ={0,20,40};
   string buttons_text[]     ={"Radio Button 1","Radio Button 2","Radio Button 3"};
   int    buttons_width[]    ={92,92,92};
//--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_radio_buttons2.AddButton(buttons_x_offset[i],buttons_y_offset[i],buttons_text[i],buttons_width[i]);
//--- Create a group of buttons
   if(!m_radio_buttons2.CreateRadioButtons(m_chart_id,m_subwin,x,y))
      return(false);
//--- Select the third button in the group
   m_radio_buttons2.SelectionRadioButton(2);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_radio_buttons2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates group of radio buttons 3                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateRadioButtons3(void)
  {
//--- Store the window pointer
   m_radio_buttons3.WindowPointer(m_window);
//--- Coordinates
   int x =m_window.X()+RADIO_BUTTONS3_GAP_X;
   int y =m_window.Y()+RADIO_BUTTONS3_GAP_Y;
//--- Properties
   int    buttons_x_offset[] ={0,0,0};
   int    buttons_y_offset[] ={0,20,40};
   string buttons_text[]     ={"Radio Button 1","Radio Button 2","Radio Button 3"};
   int    buttons_width[]    ={92,92,92};
//--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_radio_buttons3.AddButton(buttons_x_offset[i],buttons_y_offset[i],buttons_text[i],buttons_width[i]);
//--- Create a group of buttons
   if(!m_radio_buttons3.CreateRadioButtons(m_chart_id,m_subwin,x,y))
      return(false);
//--- Select the first button in the group
   m_radio_buttons3.SelectionRadioButton(0);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_radio_buttons3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates group of radio buttons 4                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateRadioButtons4(void)
  {
//--- Store the window pointer
   m_radio_buttons4.WindowPointer(m_window);
//--- Coordinates
   int x =m_window.X()+RADIO_BUTTONS4_GAP_X;
   int y =m_window.Y()+RADIO_BUTTONS4_GAP_Y;
//--- Properties
   int    buttons_x_offset[] ={0,0,0};
   int    buttons_y_offset[] ={0,20,40};
   string buttons_text[]     ={"Radio Button 1","Radio Button 2","Radio Button 3"};
   int    buttons_width[]    ={92,92,92};
//--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_radio_buttons4.AddButton(buttons_x_offset[i],buttons_y_offset[i],buttons_text[i],buttons_width[i]);
//--- Create a group of buttons
   if(!m_radio_buttons4.CreateRadioButtons(m_chart_id,m_subwin,x,y))
      return(false);
//--- Select the fourth button in the group
   m_radio_buttons4.SelectionRadioButton(3);
//--- Block the group of buttons
   m_radio_buttons4.RadioButtonsState(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_radio_buttons4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a group of icon buttons 1                                |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_gray.bmp"
//---
bool CProgram::CreateIconButtonsGroup1(void)
  {
//--- Store the window pointer
   m_icon_buttons_group1.WindowPointer(m_window);
//--- Coordinates
   int x =m_window.X()+IBUTTONS_GROUP1_GAP_X;
   int y =m_window.Y()+IBUTTONS_GROUP1_GAP_Y;
//--- Properties
   int    buttons_x_gap[] ={0,97,194};
   int    buttons_y_gap[] ={0,0,0};
   string buttons_text[]  ={"Icon button 1","Icon button 2","Icon button 3"};
   int    buttons_width[] ={92,92,92};
//--- Array of icons for the available mode
   string items_bmp_on[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp"
     };
//--- Array of icon for the blocked mode 
   string items_bmp_off[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_gray.bmp"
     };
//--- Add three buttons to the group
   m_icon_buttons_group1.ButtonsYSize(85);
   m_icon_buttons_group1.IconXGap(14);
   m_icon_buttons_group1.IconYGap(5);
   m_icon_buttons_group1.LabelXGap(15);
   m_icon_buttons_group1.LabelYGap(69);
//--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_icon_buttons_group1.AddButton(buttons_x_gap[i],buttons_y_gap[i],buttons_text[i],
                                      buttons_width[i],items_bmp_on[i],items_bmp_off[i]);
//--- Create a group of buttons
   if(!m_icon_buttons_group1.CreateIconButtonsGroup(m_chart_id,m_subwin,x,y))
      return(false);
//--- Highlight the second button in the group
   m_icon_buttons_group1.SelectedRadioButton(1);
//--- Block the group of buttons
   m_icon_buttons_group1.IconButtonsState(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_icon_buttons_group1);
   return(true);
  }
//+------------------------------------------------------------------+
