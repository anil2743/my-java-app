import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(value = "/*")
public class SessionFilter implements Filter {

    public SessionFilter() {
        super();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();

        // Allow access to login page and LoginServlet without session validation
        if (requestURI.endsWith("/login.jsp") || requestURI.endsWith("/LoginServlet")) {
            chain.doFilter(request, response);
            return;
        }

        String email = null;
        if (session != null) {
            email = (String) session.getAttribute("email");
        }

        // Validate session
        if (email != null && session != null) {
            HttpSession activeSession = UserSessionManager.getSession(email);
            if (activeSession != null && session.getId().equals(activeSession.getId())) {
                // Valid session, proceed with request
                setCacheControlHeaders(httpResponse);
                chain.doFilter(request, response);
                return;
            } else {
                // Invalid or stale session
                if (session.getAttribute("invalidated") == null) {
                    session.setAttribute("invalidated", true);
                    session.invalidate();
                }
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=sessionExpired");
                return;
            }
        }

        // No valid session, redirect to login
        setCacheControlHeaders(httpResponse);
        chain.doFilter(request, response);
    }

    private void setCacheControlHeaders(HttpServletResponse httpResponse) {
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);
    }

    @Override
    public void init(jakarta.servlet.FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}