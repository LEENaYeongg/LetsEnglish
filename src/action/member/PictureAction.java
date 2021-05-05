package action.member;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.Action;
import action.ActionForward;
/**
 * 1. 이미지 파일 업로드. request 객체 사용 불가
 * 		이미지 파일 업로드의 위치: 현재 폴더/picture 폴더로 설정
 * 2. 이미지파일의 3분의1 크기의 섬네일이미지 생성. 이름은 sm_파일이름으로 설정
 */
public class PictureAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = request.getServletContext().getRealPath("") + "model2/member/picture/";
		String fname = null;
		File f = new File(path);
		//path가 지정한 폴도가 없는 경우 폴더 생성
		if (!f.exists()) {
			f.mkdirs();
		}
		//request : 파일의 내용 이름 다 들어있음.
		MultipartRequest multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "EUC-KR");
		//업로드된 파일의 이름
		fname = multi.getFilesystemName("picture");
		BufferedImage bi = ImageIO.read(new File(path + fname));
		int width = bi.getWidth() / 3;
		int height = bi.getHeight() / 3;
		BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = thumb.createGraphics();
		g.drawImage(bi, 0, 0, width, height, null);
		f = new File(path + "sm_" + fname);
		ImageIO.write(thumb, "jpg", f);
		request.setAttribute("fname", fname);
		return new ActionForward();
	}
}
