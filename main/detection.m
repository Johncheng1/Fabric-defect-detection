function varargout = detection(varargin)
% DETECTION MATLAB code for detection.fig
%      DETECTION, by itself, creates a new DETECTION or raises the existing
%      singleton*.
%
%      H = DETECTION returns the handle to a new DETECTION or the handle to
%      the existing singleton*.
%
%      DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECTION.M with the given input arguments.
%
%      DETECTION('Property','Value',...) creates a new DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detection

% Last Modified by GUIDE v2.5 06-Mar-2018 14:53:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detection_OpeningFcn, ...
                   'gui_OutputFcn',  @detection_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before detection is made visible.
function detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detection (see VARARGIN)
mainHandle=gui2();
pause(3);
close(mainHandle);
% Choose default command line output for detection
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global tu
%  载入图像. 
  % hObject      handle to loadIm (see GCBO) 
  % eventdata   reserved - to be defined in a future version of MATLAB 
  % handles      structure with handles and user data (see GUIDATA) 
    
f3= gabor2(im,pi/2);
f4 = gabor2(im,pi/4*3);
f5=(f1+f2+f3+f4)/4;
f5=imresize(f5,[height width]);
% imshow(f5,'Parent',handles.axes3);
axis off;

%%图片融合
saliencymap=mat2gray(double(SalMap).*f5);
imshow(saliencymap,'Parent',handles.neurons);
              h=dialog('name','消息通知','position',[900 400 200 70]);  
              uicontrol('parent',h,'style','text','string','缺陷检测完成！','position',[50 40 120 20],'fontsize',10);  
              uicontrol('parent',h,'style','pushbutton','position',...  
              [80 10 50 20],'string','确定','callback','delete(gcbf)'); 
axis off;



% --- Executes during object creation, after setting all properties.
function neurons_CreateFcn(hObject, eventdata, handles)
% hObject    handle to neurons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);

% Hint: place code in OpeningFcn to populate neurons


% --- Executes during object creation, after setting all properties.

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

or','y','LineWidth',1);
% [L,m]=bwlabel(saliencymap,8);
% if m>=1
%     set(handles.text13,'String','有缺陷');
% else
%     set(handles.text13,'String','没有缺陷');

h=dialog('name','消息通知','position',[900 400 200 70]);  
uicontrol('parent',h,'style','text','string','缺陷定位完成！','position',[50 40 120 20],'fontsize',12);  
uicontrol('parent',h,'style','pushbutton','position',...  
[80 10 50 20],'string','确定','callback','delete(gcbf)'); 
axis off;



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getimage(handles.neurons);
str1=get(handles.edit1,'string');
lambda=str2num(str1);
str2=get(handles.edit2,'string');
sigma=str2num(str2);
str3=get(handles.edit3,'string');
sharpness=str2num(str3);
str4=get(handles.edit4,'string');
maxIter=str2num(str4);
S = tsmooth(I,lambda,sigma,sharpness,maxIter);
imshow(S,[],'Parent',handles.neurons);
h=dialog('name','消息通知','position',[900 400 200 70]);  
uicontrol('parent',h,'style','text','string','背景抑制完成！','position',[50 40 120 20],'fontsize',12);  
uicontrol('parent',h,'style','pushbutton','position',...  
[80 10 50 20],'string','确定','callback','delete(gcbf)'); 
axis off;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty -

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles ,'string','保存成功！','position',[50 40 120 20],'fontsize',12);  
         uicontrol('parent',h,'style','pushbutton','position',...  
         [80 10 50 20],'string','确定','callback','delete(gcbf)'); 
      end;


     

% --- Executes during object creation, after setting all properties.
function pushbutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('是否确认关闭','关闭确认','是','否','是');
if strcmp(button,'是')
    close(detection);
else
    return;
end


% --- Executes during object creation, after setting all properties.
function pushbutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
