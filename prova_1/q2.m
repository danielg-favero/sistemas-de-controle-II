clc
clear all
close all

num = 10;
den = [1 0 2];
G = tf(num, den)

Gmf = feedback(G, 1);
step(Gmf)