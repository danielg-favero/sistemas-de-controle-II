clc
clear all
close all

num = 1;
den = [1 2 2];
G = tf(num, den)

pole(feedback(G, 1))
rlocus(G)