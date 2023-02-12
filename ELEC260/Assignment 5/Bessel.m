function Bessel(filtertype)

    % Set the cutoff frequency for the filter.
    wc = 10;
    % Calculate the transfer function coefficients for the filter.
    switch filtertype
    case {'butterworth'}
        [tfnum , tfdenom] = butter (10, wc , 's');
    case {'bessel'}
        [tfnum , tfdenom] = besself (10, wc);
    end
    
    % Calculate the magnitude and phase responses.
    [freqresp , omega] = freqs(tfnum , tfdenom , linspace (-20, 20, 500));
    magresp = abs(freqresp );
    phaseresp = unwrap(angle(freqresp ));
    % Plot the magnitude and phase response (using the unwrapped phase).
    clf
    subplot (2, 1, 1);
    plot(omega , magresp );
    title('Magnitude Response ');
    xlabel('Frequency (rad/s)');
    ylabel('Magnitude (unitless)');
    subplot (2, 1, 2);
    plot(omega , phaseresp );
    title('Phase Response ');
    xlabel('Frequency (rad/s)');
    ylabel('Angle (rad)');
    print(filtertype, '-dpng');
end