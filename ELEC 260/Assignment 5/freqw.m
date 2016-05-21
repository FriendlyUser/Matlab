
function [freqResp , w] = freqw(aCoefs, bCoefs, w)
    freqResp = polyval(aCoefs, w) ./ polyval(bCoefs, w);
    % If no output arguments were specified, plot the frequency response.
    if nargout == 0
        % Compute the magnitude response.
        magResp = abs(freqResp);
        % Compute the phase response.
        phaseResp = angle(freqResp);
        figure;
        % On the first graph, plot the magnitude response.
        subplot(2, 1, 1);
        plot(w, magResp);
        title('Subplot 1: Magnitude Response');
        xlabel('Frequency (radians/s)');
        ylabel('Magnitude (no units)');
        
        % On the second graph plot the phase response.
        subplot(2, 1, 2);
        plot(w, phaseResp);
        title('Subplot 2: Phase Response');
        xlabel('Frequency (radians/s)');
        ylabel('Angle (radians)');
        savefig('freqw.fig');
    end

