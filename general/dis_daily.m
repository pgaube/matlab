{\rtf1\mac\ansicpg10000\cocoartf824\cocoasubrtf390
{\fonttbl\f0\fswiss\fcharset77 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\ql\qnatural\pardirnatural

\f0\fs24 \cf0 function [bar, sd1, sd2] = dis_daily(data)\
\
data1=data(:,:,1:(length(data(1,1,:))/2);\
i=find(~isnan(data1));\
bar1=mean(data1);\
sd1=std(data1);\
\
clear data1\
\
data1=data(:,:,(length(data(1,1,:))/2:length(data(1,1,:)));\
i=find(~isnan(data1));\
bar2=mean(data1);\
sd2=std(data1);\
bar=(bar1+bar2)/2;\
\
clear data1\
}